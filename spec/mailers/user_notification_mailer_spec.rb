require "rails_helper"

RSpec.describe UserNotificationMailer, type: :mailer do
  let!(:user) { create(:user) }

  describe "digest" do
    let!(:user) { create(:user) }
    let(:mail) { UserNotificationMailer.digest(user) }
    let(:questions) { create_list(:question, 3, user: create(:user), created_at: Date.yesterday) }

    it "renders the headers" do
      expect(mail.subject).to eq("New questions for twenty-four hours")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      questions.each do |question|
        expect(mail.body.encoded).to match(question.title)

      end
    end
  end

  describe "notify_question_subscribers" do
    let!(:subsriber) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:subscription) { create(:subscription, question: question, user: subsriber) }
    let(:answer) { create(:answer, question: question, user: create(:user)) }
    let(:mail) { UserNotificationMailer.notify_question_subscribers(subscription, answer) }

    it "renders the headers" do
      expect(mail.subject).to eq("New answer for question #{answer.question.title}")
      expect(mail.to).to eq([subsriber.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(answer.body)
    end
  end


end
