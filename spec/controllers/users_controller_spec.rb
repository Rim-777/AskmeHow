require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:all_users) {create_list(:user, 3)}
  let(:user){create(:user)}

  describe 'GET #index' do
   let(:request) {get :index}
    before do
      all_users
      request
    end
    it 'assign value for @users as All Users array' do

      expect(assigns(:users)).to match_array(all_users)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:request) {get :show, id: user}
    before do
      user
      request
    end

    it 'assign value for @user as required user' do
      expect(assigns(:user)).to eq user

    end

    it 'render show view' do
      expect(response).to render_template :show
    end

  end

  describe 'PATCH #update' do
    let(:request) {patch :update, id: user, user:{first_name: 'John', last_name: 'Smit', email: 'new123@mail.test', password: '12345678'}  }
    before { sign_in(user) }
    before do
      # user

    end

    it 'assign value for @user as required user' do
      patch :update, id: user, user:{first_name: 'John', last_name: 'Smith', email: 'new123@mail.test', password: '12345678'}
      expect(assigns(:user)).to eq user
    end

    it "change user's first_name" do
      patch :update, id: user, user:{first_name: 'John', last_name: 'Smith', email: 'new123@mail.test', password: '12345678'}
      user.reload
      expect(user.first_name).to eq 'John'
      expect(user.last_name).to eq 'Smith'

    end

  end

end
