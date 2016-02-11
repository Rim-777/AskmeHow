class QuestionSubscribersNotificationJob < ActiveJob::Base
  queue_as :default

  def perform(answer)
    answer.question.subscriptions.find_each do |subscription|
      UserNotificationMailer.notify_question_subscribers(subscription, answer).deliver_later
    end

  end
end
