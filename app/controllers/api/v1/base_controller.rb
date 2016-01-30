class Api::V1::BaseController < ApplicationController
  skip_authorization_check
  before_action :doorkeeper_authorize!
  # protect_from_forgery with: :null_session

  respond_to :json

  rescue_from CanCan::AccessDenied do |exception|
    render json: {error: 'Вы не авторизованы'}
  end

  protected

  def current_ability
    @ability ||= Ability.new(current_resource_owner)
  end


  def current_resource_owner
    @current_resource_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

end