require_relative 'acceptance_helper'

feature 'Mark Answer', %q{
In order to select the best answer on may question i
be able to mark answer} do

  given(:author_of_question) { create(:user) }
  given(:author_of_answer) { create(:user) }
  given(:another_authenticated_user) { create(:user) }

  given!(:question) { create(:question, user: author_of_question) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }

  scenario 'Author of question is trying to mark an answer on his question as best', js: true do
    sign_in(author_of_question)
    visit question_path(question)
    within "#answer_#{answer.id}" do
      expect(page).to have_content answer.body
      expect(page).to have_link 'best?'
    end

    click_on 'best?'
    sleep(1)
    within ".best_answer" do
      expect(page).to have_selector "#answer_#{answer.id}"
      expect(page).to have_content answer.body
    end

    within ".others_answers" do
      expect(page).to_not have_selector "#answer_#{answer.id}"
      expect(page).to_not have_content answer.body
    end

  end

  scenario 'Authenticate User is trying mark  as best answer on his not question', js: true do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'best?'
    end
  end

  scenario 'Un-Authenticate User is trying mark as best any answer' do
    visit question_path(question)
    expect(page).to_not have_link 'best?'
  end
end