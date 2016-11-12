require_relative 'acceptance_helper'

feature 'Edit Question', %q{
In order to correct my question
I want to be able to edit my questions} do
  given(:author_of_question) { create(:user) }
  given(:another_authenticated_user) { create(:user) }
  given!(:question) { create(:question, user: author_of_question) }

  describe 'the authenticated user and his/her question' do
    before do
      sign_in(author_of_question)
      visit question_path(question)
    end

    scenario 'the author of the question is trying to edit his/her question', js: true do
      within '.question_existed_area'  do
        expect(page).to have_content question.title
        expect(page).to have_link "question_edit_link"
        click_on "question_edit_link"
        expect(page).to have_selector 'textarea'
        expect(page).to have_button 'Save'
        fill_in "question_body_edit_#{question.id}", with: 'edited question'
        click_on 'Save'
        expect(page).to_not have_content question.body
        expect(page).to have_content 'edited question'
        expect(page).to_not have_selector 'textarea'
      end
    end
  end

  scenario "the authenticated user is trying to edit someone's question" do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.question_existed_area' do
      expect(page).to_not have_link 'Edit'
    end
  end

  scenario 'some unauthenticated user is trying to edit some question' do
    visit questions_path
    expect(page).to_not have_link 'Edit'
  end
end
