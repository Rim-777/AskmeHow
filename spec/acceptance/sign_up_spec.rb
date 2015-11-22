require 'rails_helper'

feature 'Sign_up', %q{ To ask question and write answers
I wont to be able to sign up} do

  scenario 'Un-Registered user is trying to sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'new_user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    click_on 'Sign up'
    expect(page).to have_content 'You have signed up successfully.'

  end
  given(:user) { create(:user) }
  scenario 'Un-Registered user is trying to sign up' do
    sign_in(user)
    visit new_user_registration_path
    expect(page).to have_content 'You are already signed in.'
  end

end