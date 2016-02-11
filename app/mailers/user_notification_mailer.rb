class UserNotificationMailer < ApplicationMailer

  def digest(user)
    @greeting = "Hi #{user.email}"
    @questions = Question.asked_one_day_ago
    mail to: user.email, subject: "New questions for twenty-four hours"
  end


  def notify_question_subscribers(subscription, answer)
    @greeting = "Hi #{subscription.user.email}"
    @answer = answer
    mail to: subscription.user.email, subject: "New answer for question #{@answer.question.title}"
  end


end
