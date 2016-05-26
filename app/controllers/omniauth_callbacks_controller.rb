class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_authorizations

  def facebook
  end

  def vkontakte
  end

  def twitter
  end

  private

  def set_authorizations
    social_net_data = request.env['omniauth.auth']
    if social_net_data
      @user = User.find_by_oauth(social_net_data)
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "#{social_net_data.provider.to_s.capitalize}") if is_navigational_format?
      end
    end
  end
end
