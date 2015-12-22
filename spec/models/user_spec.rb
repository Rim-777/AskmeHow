require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:opinions) }

  let!(:author_of_question) { create(:user) }
  let!(:not_author_of_question) { create(:user) }
  let!(:user_with_opinion) { create(:user) }
  let!(:question) { create(:question, user: author_of_question) }

  describe '#method say_оpinion(оpinionable, value)' do



    it "create new users' opinion for question or remove old opinion" do
      user_with_opinion.say_оpinion(question, 1)
      expect(question.opinions.first.value).to eq 1

      user_with_opinion.say_оpinion(question, -1)
      expect(question.opinions.first).to eq nil

      user_with_opinion.say_оpinion(question, -1)
      expect(question.opinions.first.value).to eq -1

    end

  end


  describe "#method author_of?(entity)" do
    it "returne true if users is author of question" do
      expect(author_of_question.author_of?(question)).to eq true
    end

    it "returne false if users is not author of question" do
      expect(not_author_of_question.author_of?(question)).to eq false
    end

  end

  describe "#method not_author_of?(entity)" do
    it "returne false if users is author of question" do
      expect(author_of_question.not_author_of?(question)).to eq false
    end

    it "returne true if users is not author of question" do
      expect(not_author_of_question.not_author_of?(question)).to eq true
    end
  end

  describe "#method is_author_of!(entity)" do
    it "define for entity.user user" do
      not_author_of_question.is_author_of!(question)
      expect(question.user).to eq not_author_of_question
    end
  end

end