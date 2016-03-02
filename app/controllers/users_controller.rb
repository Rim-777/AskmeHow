class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, except: :index
  authorize_resource

  def index
    respond_with(@users = User.all)
  end

  def show
    respond_with(@user)
  end

  def edit

  end

  def update
    @user.update(user_params) if @user.id == current_user.id
    respond_with(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name,  :avatar)
  end
end
