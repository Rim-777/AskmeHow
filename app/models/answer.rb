class Answer < ActiveRecord::Base
  include Opinionable, Attachable, Commentable, Reputationable

  belongs_to :question
  belongs_to :user

  after_create :notify_question_subscribers

  validates :user_id, :body, :question_id, presence: true
  default_scope { order(:created_at) }
  # default_scope { order(created_at: :desc) }

  def set_is_best
    ActiveRecord::Base.transaction do
      old_best_answer = question.answers.where(is_best: true).first
      unless old_best_answer == self
        question.answers.update_all(is_best: false)
        raise ActiveRecord::Rollback unless update(is_best: true)
      end
    end
  end

  private

  def notify_question_subscribers
    QuestionSubscribersNotificationJob.perform_later(self)
  end

end
