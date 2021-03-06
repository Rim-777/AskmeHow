require_relative 'acceptance_helper'

feature 'Vote for Answer', %q{
In order to show my opinion about some question
I want to be able to vote for questions} do
  given(:author_of_question) { create(:user) }
  given(:author_of_answer) { create(:user) }
  given(:some_authenticated_user) { create(:user) }
  given!(:question) { create(:question, user: author_of_question) }
  given!(:answer) { create(:answer, user: author_of_answer, question: question) }

  scenario "some authenticated user is trying to vote for someone's answer", js: true do
    sign_in(some_authenticated_user)
    visit question_path(question)
    expect(page).to have_selector '.answer_rating'
    within "#answer_#{answer.id}_rating" do
      expect(page).to have_button "positive_opinion_answer_#{answer.id}_button"
      expect(page).to have_button "negative_opinion_answer_#{answer.id}_button"
      expect(page).to have_content '0'
    end

    click_on "positive_opinion_answer_#{answer.id}_button"

    within "#answer_#{answer.id}_rating" do
      expect(page).to_not have_content '0'
      expect(page).to have_content '1'
    end

    click_on "negative_opinion_answer_#{answer.id}_button"

    within "#answer_#{answer.id}_rating" do
      expect(page).to_not have_content '1'
      expect(page).to have_content '0'
    end

    click_on "negative_opinion_answer_#{answer.id}_button"

    within "#answer_#{answer.id}_rating" do
      expect(page).to_not have_content '0'
      expect(page).to have_content '-1'
    end
  end

  scenario 'the author of the question is trying to vote for his/her Answer', js: true do
    sign_in(author_of_answer)
    visit question_path(question)

    expect(page).to have_selector '.answer_rating'
    sleep(1)
    within "#answer_#{answer.id}_rating" do
      expect(page).to have_button "positive_opinion_answer_#{answer.id}_button"
      expect(page).to have_button "negative_opinion_answer_#{answer.id}_button"
      expect(page).to have_content '0'
    end
    click_on "positive_opinion_answer_#{answer.id}_button"

    within "#answer_#{answer.id}_rating" do
      expect(page).to have_content '0'
      expect(page).to_not have_content '1'
    end

    click_on "negative_opinion_answer_#{answer.id}_button"

    within "#answer_#{answer.id}_rating" do
      expect(page).to have_content '0'
      expect(page).to_not have_content '-1'
    end
  end

  scenario 'some unautenticated user is trying to vote for some answer', js: true do
    visit question_path(question)
    expect(page).to have_selector '.answer_rating'
    within "#answer_#{answer.id}_rating" do
      expect(page).to have_button "positive_opinion_answer_#{answer.id}_button"
      expect(page).to have_button "negative_opinion_answer_#{answer.id}_button"
      expect(page).to have_content '0'
    end

    click_on "positive_opinion_answer_#{answer.id}_button"
    within "#answer_#{answer.id}_rating" do
      expect(page).to have_content '0'
      expect(page).to_not have_content '1'
    end

    click_on "negative_opinion_answer_#{answer.id}_button"
    within "#answer_#{answer.id}_rating" do
      expect(page).to have_content '0'
      expect(page).to_not have_content '-1'
    end
  end
end
