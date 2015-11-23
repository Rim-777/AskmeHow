class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :user_id, :body, :question_id, presence: true

end
