require 'rails_helper'

feature 'Create Answer', %q{
In order to help users to find correct answer as an authenticate user
I want to be able to create answers } do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticate User is trying write Answer', js: true  do


    sign_in(user)
    can_see_question
    fill_in 'You Answer', with: 'Test answer body'
    click_on 'Create'
    # expect(page).to have_content question.title
    # expect(page).to have_content question.body
    # save_and_open_page
    within '.answers' do
      expect(page).to have_content 'Test answer body'
    end

  end

  scenario 'Un-authenticate User is trying write Answer' do
    can_see_question
    # click_on 'Create'
    expect(page).to have_content 'Please log in If You want to add a new Answer.'
  end

end