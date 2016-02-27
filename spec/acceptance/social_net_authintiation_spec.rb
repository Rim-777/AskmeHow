require_relative 'acceptance_helper'
OmniAuth.config.test_mode = true
feature 'OAuth' do
  before { visit new_user_session_path }

  describe 'user try sign_in ' do
    scenario 'successfully' do
      mock_auth_hash(:twitter)
      click_on 'twitter_main_oauth_link'
      expect(page).to have_content "Successfully authenticated from Twitter account."
      expect(page).to have_content "log out"
    end

    scenario 'Un-successfully' do
      mock_auth_invalid_hash(:twitter)
      click_on 'twitter_main_oauth_link'
      expect(page).to have_content "Could not authenticate you from Twitter because \"Invalid credentials\"."
      expect(page).to have_content "Log in"
    end

  end

  describe 'user try sign_in Facebook' do

    scenario 'successfully' do
      mock_auth_hash(:facebook)
      click_on 'facebook_main_oauth_link'
      expect(page).to have_content "Successfully authenticated from Facebook account."
      expect(page).to have_content "log out"
    end

    scenario 'Un-successfully' do
      mock_auth_invalid_hash(:facebook)
      click_on 'facebook_main_oauth_link'
      expect(page).to have_content "Could not authenticate you from Facebook because \"Invalid credentials\"."
      expect(page).to have_content "Log in"
    end


  end

  describe 'Sign_in VK' do

    scenario 'successfully' do
      mock_auth_hash(:vkontakte)
      click_on 'vkontakte_main_oauth_link'
      expect(page).to have_content "Successfully authenticated from Vkontakte account."
      expect(page).to have_content "log out"
    end

    scenario 'Un-successfully' do
      mock_auth_invalid_hash(:vkontakte)
      click_on 'vkontakte_main_oauth_link'
      expect(page).to have_content "Could not authenticate you from Vkontakte because \"Invalid credentials\"."
      # save_and_open_page

      expect(page).to have_content "Log in"
    end



  end

end