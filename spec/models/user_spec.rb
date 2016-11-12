require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:opinions) }
  it { should have_many(:comments) }

  let!(:author_of_question) { create(:user) }
  let!(:not_author_of_question) { create(:user) }
  let!(:user_with_opinion) { create(:user) }
  let!(:question) { create(:question, user: author_of_question) }

  describe '#say_оpinion(оpinionable, value)' do

    it "creates a new users' opinion for the question " do
      user_with_opinion.say_оpinion(question, 1)
      expect(question.opinions.first.value).to eq 1
    end

    it "removes the old users' opinion if a new opinion is different" do
      user_with_opinion.say_оpinion(question, 1)
      user_with_opinion.say_оpinion(question, -1)
      expect(question.opinions.first).to eq nil
    end

    it "again creates a new users' opinion for the question " do
      user_with_opinion.say_оpinion(question, -1)
      expect(question.opinions.first.value).to eq -1
    end
  end

  describe '#author_of?(entity)' do
    it "returne true if users is author of question" do
      expect(author_of_question).to be_author_of(question)
    end

    it 'returnes false if users is not author of question' do
      expect(not_author_of_question).to be_not_author_of(question)
    end
  end

  describe "#not_author_of?(entity)" do
    it "returnes false if the user is the author of the question" do
      expect(author_of_question.not_author_of?(question)).to eq false
    end

    it "returnes true if the users isn't the author of the question" do
      expect(not_author_of_question.not_author_of?(question)).to eq true
    end
  end

  describe "#is_author_of!(entity)" do
    it "defines for the entity's user" do
      not_author_of_question.is_author_of!(question)
      expect(question.user).to eq not_author_of_question
    end
  end

  describe '.find_by_oauth' do
    let!(:user) { create(:user) }
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123457') }

    context 'the user already has an social net authorization' do
      it 'returns the user' do
        user.authorizations.create(provider: 'facebook', uid: '123457')
        expect(User.find_by_oauth(auth)).to eq user
      end
    end

    context 'the user still has not an social net authorization' do
      context 'user already exist but have registered without social net' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123457', info: { email: user.email }) }

        it 'does not create a new user' do
          expect { User.find_by_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates a new authorization for user' do
          expect { User.find_by_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

        it 'creates an authorization with provider and uid' do
          user = User.find_by_oauth(auth)
          authorization = user.authorizations.first
          expect(authorization.provider).to eq auth.provider
          expect(authorization.uid).to eq auth.uid
        end

        it 'returns the user' do
          expect(User.find_by_oauth(auth)).to eq user
        end
      end
    end

    context 'user does not exist' do
      context 'provider  returns an email for the user' do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '12345678', info: {email: 'new@user.ml'}) }
        it 'fills user emails' do
          user = User.find_by_oauth(auth)
          expect(user.email).to eq auth.info.email
        end
        it_return_new_user_and_authorization_by_oauth
      end

      context "provider doesn't return email" do
        let(:auth) { OmniAuth::AuthHash.new(provider: 'twitter', uid: '12345678', info: {email: nil}) }
        it 'fills tmp email for user' do
          user = User.find_by_oauth(auth)
          expect(user.email).to eq '12345678@twitter.tmp'
        end

        it_return_new_user_and_authorization_by_oauth
      end
    end
  end
end
