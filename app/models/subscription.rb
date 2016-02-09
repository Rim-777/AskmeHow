class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :question_id, :user_id, presence: true

  # def self.is_existed?(user, question)
  #   !!Subscription.where("user_id = ? AND question_id = ?", user.id, question.id ).take
  # end
  #
  # def self.is_not_existed?(user, question)
  #   !self.is_existed?(user, question)
  # end
end
