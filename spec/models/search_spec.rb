require 'rails_helper'

RSpec.describe Search, type: :model do

    let!(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:answer) { create(:answer, question: create(:question, user: user), user: user) }
    let!(:question_comment) { create(:comment, commentable: question, commentable_type: 'Question', user: user) }
    let!(:answer_comment) { create(:comment, commentable: answer, commentable_type: 'Answer', user: user) }

    describe '.result_link' do
    it 'return question.title if found result is Question' do
      expect(Search.result_link(question)).to eq question.title
    end

    it 'return answer.question.title if found result is Answer' do
      expect(Search.result_link(answer)).to eq answer.question.title
    end

    it 'return comment.question.title if found result is comment for question' do
      expect(Search.result_link(question_comment)).to eq question.title
    end

    it 'return comment.answer.question.title if found result is comment for answer' do
      expect(Search.result_link(answer_comment)).to eq answer.question.title
    end

    it 'return user.email if found result is user' do
      expect(Search.result_link(user)).to eq user.email
    end

  end

  describe '.result_path' do
    it 'return question if found result is Question' do
      expect(Search.result_path(question)).to eq question
    end

    it 'return answer.question if found result is Answer' do
      expect(Search.result_path(answer)).to eq answer.question
    end

    it 'return comment.question if found result is comment for question' do
      expect(Search.result_path(question_comment)).to eq question
    end

    it 'return comment.answer.question if found result is comment for answer' do
      expect(Search.result_path(answer_comment)).to eq answer.question
    end

    it 'return user if found result is User' do
      expect(Search.result_path(user)).to eq user
    end
  end

end