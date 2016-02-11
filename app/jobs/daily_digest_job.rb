class DailyDigestJob < ActiveJob::Base
  queue_as :default

  def perform
    User.find_each do |user|
      UserNotificationMailer.digest(user).deliver_later
    end
  end
end
