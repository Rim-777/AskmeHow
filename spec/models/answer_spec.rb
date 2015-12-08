require 'rails_helper'

RSpec.describe Answer, type: :model do

  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :question_id }
  it { should belong_to(:question) }
  it { should belong_to(:user) }


  describe 'method set_is_best' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: question, user: user) }
    let!(:second_answer) { create(:answer, question: question, user: user) }
    let!(:one_more_answer) { create(:answer, question: question, user: user, is_best: true) }

    it "put fields' value 'is_best' as true for selected answer,
        and false for all others answers concerning theirs' question" do
      answer.set_is_best
      answer.question.answers.each do |other_answer|
        other_answer.reload
        if other_answer == answer
          expect(other_answer.is_best?).to eq true
        else
          expect(other_answer.is_best?).to eq false
        end
      end
    end

  end
end
