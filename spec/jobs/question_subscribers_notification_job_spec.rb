require 'rails_helper'

RSpec.describe QuestionSubscribersNotificationJob, type: :job do
  let!(:question) { create(:question, user: create(:user)) }
  let!(:subscription1) { create(:subscription, question_id: question.id, user_id: create(:user).id) }
  let!(:subscription2) { create(:subscription, question_id: question.id, user_id: create(:user).id) }
  let!(:subscription3) { create(:subscription, question_id: question.id, user_id: create(:user).id) }
  let(:answer) { create(:answer, question: question, user: create(:user)) }

  it 'sends question subscribers notification' do
    question.subscriptions.find_each do |subscription|
      expect(UserNotificationMailer).to receive(:notify_question_subscribers).with(subscription, answer).and_call_original
    end

    QuestionSubscribersNotificationJob.perform_now(answer)
  end
end