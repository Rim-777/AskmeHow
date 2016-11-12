class Question < ActiveRecord::Base
  include Opinionable, Attachable, Commentable, Reputationable
  has_many :answers, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :user
  validates :title, :body, :user_id, presence: true
  after_create :subscribe_with_author, :publish_question
  scope :asked_one_day_ago, -> { where(created_at: Date.yesterday) }
  default_scope { order(created_at: :desc) }

  def best_answer
    answers.where(is_best: true).first
  end

  def is_not_subscribed_with?(user)
    !self.is_subscribed_with?(user)
  end

  def is_subscribed_with?(user)
    !!self.subscriptions.where(user_id: user.id).first
  end

  private
  def subscribe_with_author
    self.subscriptions.create(user_id: self.user_id)
  end

  def publish_question
    question_data = {
        title: self.title,
        id: self.id,
        author_id: self.user_id,
        author_name: self.user.email,
        created_at: self.created_at.to_date,
        rating: self.opinions.rating,
        answers_number: self.answers.count}
    PrivatePub.publish_to "/questions", question: question_data.to_json if self.errors.empty?
  end
end
