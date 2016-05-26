def given_user_with_question_and_answers_from_model_macros
  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:second_answer) { create(:answer, question: question, user: user) }
  let!(:one_more_answer) { create(:answer, question: question, user: user, is_best: true) }
end

def it_return_new_user_and_authorization_by_oauth
  it 'create new user' do
    expect { User.find_by_oauth(auth) }.to change(User, :count).by(1)
  end

  it 'returns new user' do
    expect(User.find_by_oauth(auth)).to be_a(User)
  end

  it 'create authorizations for user' do
    user = User.find_by_oauth(auth)
    expect(user.authorizations).to_not be_empty
  end

  it 'creates authorization with provider and uid ' do
    authorization = User.find_by_oauth(auth).authorizations.first
    expect(authorization.provider).to eq auth.provider
    expect(authorization.uid).to eq auth.uid
  end
end
