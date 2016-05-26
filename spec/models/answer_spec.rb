require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :question_id }
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should accept_nested_attributes_for(:attachments) }
  it { should have_many(:opinions).dependent(:destroy) }

  describe 'reputation' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    subject { build(:answer, question: question, user: user) }
    it_behaves_like 'Reputationable'
  end

  given_user_with_question_and_answers_from_model_macros

  describe '#method set_is_best' do
    it "put fields' value 'is_best' as true for selected answer,
        and false for all others answers concerning theirs' question" do
      answer.set_is_best
      answer.question.answers.each do |the_answer|
        the_answer.reload
        if the_answer == answer
          expect(the_answer.is_best?).to eq true
        else
          expect(the_answer.is_best?).to eq false
        end
      end
    end
  end

  describe '#type_and_id' do
    it "return string with class_name and id of opinmonable entity" do
      expect(answer.type_and_id).to eq "answer_#{answer.id}"
    end
  end

  describe 'it put in cue sending notification after creation of new answer' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    subject { build(:answer, question: question, user: user) }

    it 'should calculate user reputation after create' do
      expect(QuestionSubscribersNotificationJob).to receive(:perform_later).with(subject)
      subject.save!
    end
  end
end
