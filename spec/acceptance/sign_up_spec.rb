require_relative 'acceptance_helper'

feature 'Sign_up', %q{ To ask questions and write answers
I want to be able to sign up} do
  scenario 'som unregistered user is trying to sign up' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'new_user@test.com'
    fill_in 'sign_up_password_field', with: '12345678'
    fill_in 'sign_up_password_confitmation_field', with: '12345678'
    click_on 'Sign up'
    expect(page).to have_content 'You have signed up successfully.'
  end

  given(:user) { create(:user) }
  scenario 'the registered user is trying to sign up' do
    sign_in(user)
    visit new_user_registration_path
    expect(page).to have_content 'You are already signed in.'
  end
end
