module OmniauthMacros
  def mock_auth_hash(provider)
    OmniAuth.config.mock_auth[provider.to_sym] =
        OmniAuth::AuthHash.new(provider: provider.to_s, uid: '123545678',
                               info: {mail: provider == :twitter ? nil : 'new@user.ml'})
  end


  def mock_auth_invalid_hash(provider)
    OmniAuth.config.mock_auth[provider.to_sym] = :invalid_credentials

  end
end