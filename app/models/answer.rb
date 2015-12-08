class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_id, :body, :question_id, presence: true

  def set_is_best
    ActiveRecord::Base.transaction do
      question.answers.update_all(is_best: false)
      raise ActiveRecord::Rollback unless update_attribute(:is_best, true)
    end
  end
end
