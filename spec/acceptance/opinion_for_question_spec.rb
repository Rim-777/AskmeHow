 require_relative 'acceptance_helper'

feature 'Vote for Question', %q{
In order to show my opinion about some question
I want to be able to vote for questions} do
  given(:author_of_question) { create(:user) }
  given(:some_authenticated_user) { create(:user) }
  given!(:question) { create(:question, user: author_of_question) }

  scenario "some authenticated user is trying to vote for someone's question", js: true do
    sign_in(some_authenticated_user)
    visit question_path(question)

    expect(page).to have_selector '.question_rating'
    within '.question_rating' do
      expect(page).to have_button "positive_opinion_question_#{question.id}_button"
      expect(page).to have_button "negative_opinion_question_#{question.id}_button"
      expect(page).to have_content '0'
    end

    click_on "positive_opinion_question_#{question.id}_button"
    within '.question_rating' do
      expect(page).to_not have_content '0'
      expect(page).to have_content '1'
    end

    click_on "negative_opinion_question_#{question.id}_button"

    within '.question_rating' do
      expect(page).to_not have_content '1'
      expect(page).to have_content '0'
    end

    click_on "negative_opinion_question_#{question.id}_button"
    within '.question_rating' do
      expect(page).to_not have_content '0'
      expect(page).to have_content '-1'
    end
  end

  scenario 'the author of the question is trying to vote for his/her question', js: true do
    sign_in(author_of_question)
    visit question_path(question)

    expect(page).to have_selector '.question_rating'
    within '.question_rating' do
      expect(page).to have_button "positive_opinion_question_#{question.id}_button"
      expect(page).to have_button "negative_opinion_question_#{question.id}_button"
      expect(page).to have_content '0'
    end

    click_on "positive_opinion_question_#{question.id}_button"
    within '.question_rating' do
      expect(page).to have_content '0'
      expect(page).to_not have_content '1'
    end

    click_on "negative_opinion_question_#{question.id}_button"
    within '.question_rating' do
      expect(page).to have_content '0'
      expect(page).to_not have_content '-1'
    end
  end

  scenario 'some unautenticated user is trying to vote for some question', js: true do
    visit question_path(question)

    expect(page).to have_selector '.question_rating'
    within '.question_rating' do
      expect(page).to have_button "positive_opinion_question_#{question.id}_button"
      expect(page).to have_button "negative_opinion_question_#{question.id}_button"
      expect(page).to have_content '0'
    end

    click_on "positive_opinion_question_#{question.id}_button"
    within '.question_rating' do
      expect(page).to have_content '0'
      expect(page).to_not have_content '1'
    end

    click_on "negative_opinion_question_#{question.id}_button"
    within '.question_rating' do
      expect(page).to have_content '0'
      expect(page).to_not have_content '-1'
    end
  end
end
