require_relative 'acceptance_helper'

feature 'Delete Answer', %q{
In order to remove  not actual my answer
I want to be able to delete my answers} do
  given(:author_of_question) { create(:user) }
  given(:author_of_answer) { create(:user) }
  given(:another_authenticated_user) { create(:user) }
  given(:question) { create(:question, user: author_of_question) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }

  describe 'Authenticate User and his answer' do
    before do
      sign_in(author_of_answer)
      visit question_path(question)
    end

    scenario 'Author of Answer is trying tp remove his Answer', js: true do
      within '.answers' do
        expect(page).to have_content answer.body
        expect(page).to have_link "answer_#{answer.id}_remove_link"
        click_on "answer_#{answer.id}_remove_link"
        expect(page).to_not have_content answer.body
      end
    end
  end

  scenario 'Authenticate User is trying delete his not Answer' do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'delete'
    end
  end

  scenario 'Un-Authenticate User is trying edit an Answer' do
    visit question_path(question)
    expect(page).to_not have_link 'delete'
  end
end
