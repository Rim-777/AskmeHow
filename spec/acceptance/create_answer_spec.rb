require_relative 'acceptance_helper'

feature 'Create Answer', %q{
In order to help users to find some correct answer as an authenticated user
I want to be able to create  answers } do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'the authenticated user is trying to add an answer', js: true  do
    sign_in(user)
    visit question_path(question)
    fill_in 'You Answer:', with: 'Test answer body'
    click_on 'Create'
    within '.answers' do
      expect(page).to have_content 'Test answer body'
    end
  end

  scenario 'some unauthenticated user is trying to add an answer' do
    can_see_question
    expect(page).to have_content 'Please log in If You want to add a new Answer.'
  end

  scenario 'the user is trying create an invalid answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Create'
    expect(page).to have_content "Body can't be blank"
  end
end
