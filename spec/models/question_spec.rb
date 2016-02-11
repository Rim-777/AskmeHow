require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:attachments).dependent(:destroy) }
  it { should accept_nested_attributes_for(:attachments) }
  it { should have_many(:opinions).dependent(:destroy) }

  let(:author_of_question) { create(:user) }
  let!(:question) { create(:question, user: author_of_question) }

  describe 'reputation ' do
    subject { build(:question, user: author_of_question) }
    it_behaves_like 'Reputationable'
  end

  describe '# is_subscribed_with?' do
    let(:subscriber) { create(:user) }
    let(:subscription) { create(:subscription, user: subscriber, question: question) }

    it 'return true if question is subscribed with author of question' do
      expect(question.is_subscribed_with?(author_of_question)).to eq true
    end

    it 'return true if question is subscribed with subscriber' do
      subscription
      expect(question.is_subscribed_with?(subscriber)).to eq true
    end

    it 'return true if question is not subscribed with subscriber' do
      expect(question.is_subscribed_with?(subscriber)).to eq false
    end

  end

  describe '#is_not_subscribed_with?' do
    let(:subscriber) { create(:user) }
    let(:subscription) { create(:subscription, user: subscriber, question: question) }

    it 'return false if question is subscribed with subscriber' do
      subscription
      expect(question.is_not_subscribed_with?(subscriber)).to eq false
    end

    it 'return true if question is not subscribed with subscriber' do
      expect(question.is_not_subscribed_with?(subscriber)).to eq true
    end

  end


  describe 'PATH/#best_answer' do
    let!(:best_answer) { create(:answer, question: question, user: create(:user), is_best: true) }
    let!(:other_answer) { create(:answer, question: question, user: create(:user), is_best: false) }

    it 'return one answer from his answers, that has value of field "is_best" - true' do
      expect(question.best_answer).to eq best_answer
      expect(question.best_answer).to_not eq other_answer
    end

  end
end
