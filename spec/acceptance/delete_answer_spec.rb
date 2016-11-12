require_relative 'acceptance_helper'

feature 'Delete Answer', %q{
In order to remove my answer
I want to be able to delete my answers} do
  given(:author_of_question) { create(:user) }
  given(:author_of_answer) { create(:user) }
  given(:another_authenticated_user) { create(:user) }
  given(:question) { create(:question, user: author_of_question) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }

  describe 'the authenticated user and his/her answer' do
    before do
      sign_in(author_of_answer)
      visit question_path(question)
    end

    scenario 'the author of the answer is trying to remove his/her answer', js: true do
      within '.answers' do
        expect(page).to have_content answer.body
        expect(page).to have_link "answer_#{answer.id}_remove_link"
        click_on "answer_#{answer.id}_remove_link"
        expect(page).to_not have_content answer.body
      end
    end
  end

  scenario "the authenticated user is trying to delete someone's answer" do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'delete'
    end
  end

  scenario 'some unauthenticated user is trying to delete some answer' do
    visit question_path(question)
    expect(page).to_not have_link 'delete'
  end
end
