module ControllerMacros
  def sign_in_user
    before do
      @user = create(:user)
      # следующая  строка определяет, является-ли пользователь  админом, или обычным пользователем:
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end
end
