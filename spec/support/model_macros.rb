def given_user_with_question_and_answers_from_model_macros
  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:second_answer) { create(:answer, question: question, user: user) }
  let!(:one_more_answer) { create(:answer, question: question, user: user, is_best: true) }
end