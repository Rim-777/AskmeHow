require_relative 'acceptance_helper'

feature 'Edit Question', %q{
In order to correct mistakes in my question
I want to be able to edit my question} do
  given(:author_of_question) { create(:user) }
  given(:another_authenticated_user) { create(:user) }

  given!(:question) { create(:question, user: author_of_question) }

  describe 'Authenticate User and his Question' do

    before do
      sign_in(author_of_question)
      visit question_path(question)
    end

    scenario 'Author of Question is trying edit his Question', js: true do
      within '.question_existed_area'  do
        expect(page).to have_content question.title.upcase
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

  scenario 'Authenticate User is trying edit his not Question' do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.question_existed_area' do
      expect(page).to_not have_link 'Edit'
    end
  end

  scenario 'Un-Authenticate User is trying edit an Question' do
    visit questions_path
    expect(page).to_not have_link 'Edit'
  end
end