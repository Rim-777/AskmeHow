class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_id, :body, :question_id, presence: true

  def set_is_best
    self.class.transaction do
      question.answers.update_all(is_best: false)
      update_attribute(:is_best, true)
    end
  end
end
