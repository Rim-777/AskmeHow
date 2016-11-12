require_relative 'acceptance_helper'

feature 'Mark Answer', %q{
In order to select the best answer of may question I'd like to
be able to mark an answer as the best} do
  given(:author_of_question) { create(:user) }
  given(:author_of_answer) { create(:user) }
  given(:another_authenticated_user) { create(:user) }
  given!(:question) { create(:question, user: author_of_question) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }

  scenario 'the author of the question is trying to mark some answer of his/her question as the best', js: true do
    sign_in(author_of_question)
    visit question_path(question)
    within "#answer_#{answer.id}" do
      expect(page).to have_content answer.body
      expect(page).to have_button "answer_best_link_#{answer.id}"
    end

    click_on "answer_best_link_#{answer.id}"
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

  scenario "the authenticated user is trying to mark as the best some answer of someone's question", js: true do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_button "answer_best_link_#{answer.id}"
    end
  end

  scenario 'some unauthenticated user is trying to mark as the best any answer' do
    visit question_path(question)
    expect(page).to_not have_button "answer_best_link_#{answer.id}"
  end
end
