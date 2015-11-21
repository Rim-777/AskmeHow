require 'rails_helper'

feature 'Create Answer', %q{
In order to help users to find correct answer as an authenticate user
I want to be able to create answers } do
  given(:user) {create(:user)}
  given(:question) { create(:question) }

  scenario 'Authenticate User is trying write Answer' do
    sign_in(user)
    can_see_question
    fill_in 'Body', with: 'Test question body'
    click_on 'Create'
    expect(page).to have_content question.title
    expect(page).to have_content 'Test question body'
  end

  scenario 'Un-authenticate User is trying write Answer' do
    can_see_question
    click_on 'Create'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end