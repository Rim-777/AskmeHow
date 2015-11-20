require 'rails_helper'


feature 'Create Question', %q{
In order to get answer as an authenticate user
I want to be able to ask questions } do

  scenario 'Authenticate User is trayng ask a question' do
    User.create!(email: 'user@test.com', password: '12345678')
    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test question body'
    click_on 'Create'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Test question body'
  end

  scenario 'Un-authenticate User is trayng ask a question' do
    visit questions_path
    click_on 'Ask question'
    # save_and_open_page
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end