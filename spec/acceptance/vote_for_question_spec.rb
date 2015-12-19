require_relative 'acceptance_helper'

feature 'Vote for Question', %q{
In order to show my opinion about some question
I want to be able to vote for question} do
  given(:author_of_question) { create(:user) }
  given(:some_authenticated_user) { create(:user) }
  given!(:question) { create(:question, user: author_of_question) }



  scenario 'Some authenticated user is trying vote for his not Question', js: true do
        sign_in(some_authenticated_user)
        visit question_path(question)
    within '.question_existed_area'  do


      expect(page).to have_link "up_vote_question_#{question.id}_link"
      expect(page).to have_link "down_vote_question_#{question.id}_link"
      expect(page).to have_selector '.question_rating'
        # within '.question_rating' do
        #   expect(page).to have_content '0'
        # end
        #
        # click_on "up_vote_question_#{question.id}_link"
        #
        # within '.question_rating' do
        #   expect(page).to_not have_content '0'
        #   expect(page).to have_content '1'
        # end
        #
        # click_on "down_vote_question_#{question.id}_link"
        #
        # within '.question_rating' do
        #   expect(page).to_not have_content '1'
        #   expect(page).to have_content '0'
        # end
        #
        # click_on "down_vote_question_#{question.id}_link"
        #
        # within '.question_rating' do
        #   expect(page).to_not have_content '0'
        #   expect(page).to have_content '-1'
        # end

    end

  end

end