class Question < ActiveRecord::Base
  include Opinionable, Attachable, Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :body, :user_id, presence: true

  def best_answer
    answers.where(is_best: true).first
  end

end
