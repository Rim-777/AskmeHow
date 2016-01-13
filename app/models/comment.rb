class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable
  validates :body, :commentable_id, :commentable_type, :user_id, presence: true
end
