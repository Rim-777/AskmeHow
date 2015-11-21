require 'rails_helper'

feature 'Browse questions', %q{
Before ask my question
I want to be able to  browse the questions
to find similar questions } do
  given(:user) {create(:user)}

  scenario 'Authenticate User is trying to  browse the questions' do
    sign_in(user)
    visit questions_path
  end

  scenario 'Authenticate User is trying to  browse the questions' do
    visit questions_path
  end

end