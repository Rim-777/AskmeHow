require 'rails_helper'

describe 'Ability' do
  subject(:ability) { Ability.new(user) }

  describe 'Ability for guest' do
    let(:user) { nil }
    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }
    it { should_not be_able_to :manage, :all }
  end

  describe 'Ability for admin' do
    let(:user) { create :user, admin: true }
    it { should be_able_to :manage, :all }
  end

  describe 'Ability for simple authenticate user' do
    let(:user) { create :user, admin: false }
    let(:question) { create(:question, user: user) }
    let(:other_user) { create :user, admin: false }
    let(:question_of_other_user) { create(:question, user: other_user) }
    let(:question_attachment) { create(:attachment, attachable: question) }
    let(:answer_of_user) { create(:answer, question: question_of_other_user, user: user) }
    let(:answer_of_other_user) { create(:answer, question: question, user: other_user) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, question, user: user }
    it do
      should_not be_able_to :update, create(:question,
                                            user: other_user), user: user
    end

    it do
      should be_able_to :update, create(:answer,
                                        question: question,
                                        user: user), user: user
    end

    it do
      should_not be_able_to :update, create(:answer,
                                            question: question,
                                            user: other_user), user: user
    end

    it { should be_able_to :destroy, question, user: user }

    it do
      should_not be_able_to :destroy, create(:question,
                                             user: other_user), user: user
    end

    it do
      should be_able_to :destroy, create(:answer,
                                         question: question,
                                         user: user), user: user
    end

    it do
      should_not be_able_to :destroy, create(:answer,
                                             question: question,
                                             user: other_user), user: user
    end

    it { should be_able_to :destroy, question_attachment, attachable: { user: user } }
    it { should_not be_able_to :destroy, create(:attachment) }

    it do
      should be_able_to :select_best, create(:answer,
                                             question: question,
                                             user: other_user), user: user
    end

    it do
      should_not be_able_to :select_best, create(:answer,
                                                 question: question_of_other_user,
                                                 user: other_user), user: user
    end

    it do
      should be_able_to :say_opinion_for, question_of_other_user, user: user
    end

    it { should_not be_able_to :say_opinion_for, question, user: user }
    it { should be_able_to :say_opinion_for, answer_of_other_user, user: user }
    it { should_not be_able_to :say_opinion_for, answer_of_user, user: user }
  end
end
