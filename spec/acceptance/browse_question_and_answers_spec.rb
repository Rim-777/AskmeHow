require_relative 'acceptance_helper'

feature "Browse question and it's answers", %q{To find the answer or to answer the question,
I want to be able to browse the question and it's answers
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, :with_answers, user: user) }

  scenario 'the authenticated user is trying to see a question and answers', js: true do
    sign_in(user)
    can_see_question(with_answers: true)
  end

  scenario 'some unauthenticated user is trying to see a question and answers', js: true do
    can_see_question(with_answers: true)
  end
end
