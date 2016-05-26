require_relative 'acceptance_helper'

feature 'Create Comment', %q{
In order to comment answers  as an authenticate user
I want to be able to  create comment } do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, user: user, question: question, body: "123") }

  scenario 'Authenticate User is trying to add comment to answer', js: true do
    sign_in(user)
    visit question_path(question)
    within '.answers .answer_comments' do
      expect(page).to have_field "answer_#{answer.id}_comment_add_area"

      fill_in "answer_#{answer.id}_comment_add_area", with: ''
      # sleep(1)
      expect(page).to_not have_field "answer_#{answer.id}_comment_add_area"
      expect(page).to have_field "answer_#{answer.id}_comment_body_area"
      expect(page).to have_button "answer_#{answer.id}_add_comment_button"

      fill_in "answer_#{answer.id}_comment_body_area", with: 'some comment text'
      click_on "answer_#{answer.id}_add_comment_button"
      # sleep(1)
      expect(page).to have_content 'some comment text'

      expect(page).to_not have_field "answer_#{answer.id}_comment_body_area"
      expect(page).to_not have_button "answer_#{answer.id}_add_comment_button"
      expect(page).to have_field "answer_#{answer.id}_comment_add_area"
    end
    within "#answer_#{answer.id}_comments" do
      expect(page).to have_content 'some comment text'
    end
  end

  scenario 'Un-authenticate User is trying to add comment to answer', js: true do
    visit question_path(question)
    within '.answers .answer_comments' do
      fill_in "answer_#{answer.id}_comment_add_area", with: ''
      fill_in "answer_#{answer.id}_comment_body_area", with: 'some comment text'
      click_on "answer_#{answer.id}_add_comment_button"

      expect(page).to_not have_content 'some comment text'
      expect(page).to have_field "answer_#{answer.id}_comment_body_area"
      expect(page).to have_button "answer_#{answer.id}_add_comment_button"
      expect(page).to_not have_field "answer_#{answer.id}_add_area"
    end
  end

  scenario 'User  is trying create invalid comment', js: true do
    sign_in(user)
    visit question_path(question)
    within '.answer_comments' do

      fill_in "answer_#{answer.id}_comment_add_area", with: ''
      sleep(1)
      click_on "answer_#{question.id}_add_comment_button"
      expect(page).to have_field "answer_#{answer.id}_comment_body_area"
      expect(page).to have_button "answer_#{question.id}_add_comment_button"
      expect(page).to_not have_field "answer_#{answer.id}_add_area"
    end
  end
end
