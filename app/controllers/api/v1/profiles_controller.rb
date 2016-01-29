class Api::V1::ProfilesController < Api::V1::BaseController
  skip_authorization_check


  def me
    respond_with(current_resource_owner)
  end

  def index
    @users = User.all
    respond_with(@users)
  end

  def other_users
    @other_users = User.where.not(id:current_resource_owner)
    respond_with(@other_users)
  end

end