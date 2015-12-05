require_relative 'acceptance_helper'

feature 'Mark Answer', %q{
In order to select the best answer on may question i
be able to mark answer} do

  given(:author_of_question) { create(:user) }
  given(:author_of_answer) { create(:user) }
  given(:another_authenticated_user) { create(:user) }

  given!(:question) { create(:question, user: author_of_question) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }

  scenario 'Author of question is trying to mark an answer on hos question as a correct', js: true do
    sign_in(author_of_question)
    visit question_path(question)
    within "#answer_#{answer.id}" do
      expect(page).to have_content answer.body
      expect(page).to have_link 'best?'
    end

    click_on 'best?'
    within ".best_answer" do
      expect(page).to have_selector "#answer_#{answer.id}"
      expect(page).to have_content answer.body
    end

    within ".others_answers" do
      expect(page).to_not have_selector "#answer_#{answer.id}"
      expect(page).to_not have_content answer.body
    end

  end
end