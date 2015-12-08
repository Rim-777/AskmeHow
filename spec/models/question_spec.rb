require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers).dependent(:destroy) }

  describe 'method best_answer' do

    let(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:best_answer) { create(:answer, question: question, user: user, is_best: true) }
    let!(:other_answer) { create(:answer, question: question, user: user, is_best: false) }

    it 'return one answer from his answers, that has value of field "is_best" - true' do
      expect(question.best_answer).to eq best_answer
      expect(question.best_answer).to_not eq other_answer
    end

  end
end
