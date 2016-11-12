require_relative 'acceptance_helper'

feature 'Browse questions', %q{
Before to ask my question
I want to be able to  browse the questions
to find similar questions } do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:questions) { create_list(:question, 3, user: another_user) }

  before { questions }
  scenario 'the authenticated user is trying to browse questions' do
    sign_in(user)
    can_see_full_question_list
  end

  scenario 'some unauthenticated user is trying to browse questions' do
    can_see_full_question_list
  end
end
