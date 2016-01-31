class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at
  has_one :commentable_id
  has_one :commentable_type
  has_one :user_id
end
