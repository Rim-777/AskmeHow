class Question < ActiveRecord::Base
  include Opinionable, Attachable, Commentable, Reputationable

  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :user

  scope :asked_one_day_ago, -> { where(created_at: Date.yesterday) }
  default_scope { order(:created_at)}
  validates :title, :body, :user_id, presence: true

  def best_answer
    answers.where(is_best: true).first
  end

  def is_not_subscribed_with?(user)
    !self.is_subscribed_with?(user)
  end

  def is_subscribed_with?(user)
    !!self.subscriptions.where(user_id: user.id).first
  end



end
