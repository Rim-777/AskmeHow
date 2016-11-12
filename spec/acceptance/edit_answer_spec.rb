require_relative 'acceptance_helper'

feature 'Edit Answer', %q{
In order to correct my answer
I want to be able to edit my answers} do
  given(:author_of_question) { create(:user) }
  given(:author_of_answer) { create(:user) }
  given(:another_authenticated_user) { create(:user) }
  given(:question) { create(:question, user: author_of_question) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }

  scenario 'some unathenticated user is trying to edit an answer' do
    visit question_path(question)
    expect(page).to_not have_link 'edit'
  end

  describe 'the authenticated user and his/her answer' do
    before do
      sign_in(author_of_answer)
      visit question_path(question)
    end

    scenario 'the author of the answer is trying to edit his/her answer', js: true do
      within '.answers' do
        expect(page).to have_content answer.body
        expect(page).to have_link "answer_edit_link_#{answer.id}"
        click_on  "answer_edit_link_#{answer.id}"
        expect(page).to have_selector 'textarea'
        expect(page).to have_button 'Save'
        fill_in "answer_body_edit_#{answer.id}", with: 'edited answer'
        click_on 'Save'
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end
  end

  scenario "the authenticated user is trying to edit someone's answer" do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'edit'
    end
  end
end
