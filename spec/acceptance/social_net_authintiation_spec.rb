require_relative 'acceptance_helper'

OmniAuth.config.test_mode = true
feature 'OAuth' do
  before { visit new_user_session_path }

    scenario 'user try sign_in Twitter' do
      mock_auth_hash(:twitter)
      click_on 'Sign in with Twitter'
      expect(page).to have_content "Successfully authenticated from Twitter account."
      expect(page).to have_content "log out"
    end


    scenario 'user try sign_in Facebook' do
      mock_auth_hash(:facebook)
      click_on 'Sign in with Facebook'
      expect(page).to have_content "Successfully authenticated from Facebook account."
      expect(page).to have_content "log out"
    end


    scenario 'user try sign_in  VK' do
      mock_auth_hash(:vkontakte)
      click_on 'Sign in with Vkontakte'
      expect(page).to have_content "Successfully authenticated from Vkontakte account."
      expect(page).to have_content "log out"
    end

end