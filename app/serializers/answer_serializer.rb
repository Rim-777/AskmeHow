class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at

  has_many :attachments
  has_many :comments
  has_one :user_id
  has_one :question_id
end
