require 'rails_helper'


feature 'User sign in', %q{
To be able to ask questions
as a User, I want be able to
sign in} do

  scenario 'Registered user is trying to sign in' do
    User.create!(email: 'user@test.com', password: '12345678')
    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Un-registered user is trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'not_user@test.com'
    fill_in 'Password', with: '12345678'
    # save_and_open_page
    click_on 'Log in'
    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end


end