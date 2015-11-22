class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :title, :body, :question_id, presence: true

end
