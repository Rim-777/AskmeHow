require_relative 'acceptance_helper'

feature 'Create Answer', %q{
In order to help users to find correct answer as an authenticate user
I want to be able to create answers } do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }

  scenario 'Authenticate User is trying write Answer', js: true  do
    sign_in(user)
    visit question_path(question)
    fill_in 'You Answer:', with: 'Test answer body'
    click_on 'Create'
    within '.answers' do
      expect(page).to have_content 'Test answer body'
    end
  end

  scenario 'Un-authenticate User is trying write Answer' do
    can_see_question
    expect(page).to have_content 'Please log in If You want to add a new Answer.'
  end

  scenario 'User  is trying create invalid Answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Create'
    expect(page).to have_content "Body can't be blank"
  end
end
