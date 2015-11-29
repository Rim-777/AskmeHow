require_relative 'acceptance_helper'



feature 'Create Question', %q{
In order to get answer as an authenticate user
I want to be able to ask questions } do
  given(:user) {create(:user)}
  scenario 'Authenticate User is trying ask a question' do

   sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test question body'
    click_on 'Create'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Test question body'
  end

  scenario 'Un-authenticate User is trying ask a question' do
    visit questions_path
    click_on 'Ask question'
    # save_and_open_page
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end