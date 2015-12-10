class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_id, :body, :question_id, presence: true

  def set_is_best
    ActiveRecord::Base.transaction do
      old_best_answer = question.answers.where(is_best: true).first
      unless old_best_answer == self
        question.answers.update_all(is_best: false)
        raise ActiveRecord::Rollback unless update(is_best: true)
      end
    end
  end
end
