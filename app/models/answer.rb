class Answer < ActiveRecord::Base
  belongs_to :question

  validates :title, :body, :question_id, presence: true

end
