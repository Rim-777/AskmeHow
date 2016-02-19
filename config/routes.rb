require 'sidekiq/web'
Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  concern :commentable do
    resources :comments, only: :create
  end


  resources :questions, concerns: :commentable, defaults: {commentable: 'question'}, shallow: true do
    resources :answers, concerns: :commentable, defaults: {commentable: 'answer'} do
      patch :select_best, on: :member
    end
    resource :subscription, only: [:create, :destroy]
  end

  resources :attachments, only: :destroy

  resource :opinion, only: [:positive, :negative] do
    patch :positive, on: :member
    patch :negative, on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :questions, only: [:index, :show, :create], shallow: true do
        resources :answers, only: [:index, :show, :create]
      end

      resources :profiles, only: [:index] do
        get :me, on: :collection
        get :other_users, on: :collection
      end
    end
  end

  resource :search, only: :search do
    get :search
  end

  resources :users

  root to: "questions#index"

end
