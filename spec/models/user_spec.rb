require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:opinions) }



  describe 'method say_оpinion(оpinionable, value)' do

    let!(:user) { create(:user) }
    let!(:user_with_opinion) { create(:user) }
    let!(:question) { create(:question, user: user) }

    it "create new users' opinion for question or remove old opinion" do
      user_with_opinion.say_оpinion(question, 1)
      expect(question.opinions.first.value).to eq 1

      user_with_opinion.say_оpinion(question, -1)
      expect(question.opinions.first).to eq nil

      user_with_opinion.say_оpinion(question, -1)
      expect(question.opinions.first.value).to eq -1

    end

  end
end