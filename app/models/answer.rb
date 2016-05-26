class Answer < ActiveRecord::Base
  include Opinionable, Attachable, Commentable, Reputationable
  belongs_to :question, touch: true
  belongs_to :user
  after_create :notify_question_subscribers, :publish_answer
  validates :user_id, :body, :question_id, presence: true
  default_scope { order(created_at: :desc) }

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

  def publish_answer
    answer_data = {
        answer_id: self.id,
        answer_rating: self.opinions.rating,
        answer_body: self.body,
        answer_attachments: self.attachments,
        answer_author_name: self.user.email,
        answer_author_id: self.user_id,
        answer_question_author_id: self.question.user_id,
        answers_count: self.question.answers.count
    }

    PrivatePub.publish_to "/question/#{self.question_id}/answers", answer: answer_data.to_json if self.errors.empty?
  end
end
