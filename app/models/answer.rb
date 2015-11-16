class Answer < ActiveRecord::Base
  validates :title, :body, presence: true
  belongs_to :question

end
