class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :updated_at, :short_title
  has_many :answers
  has_many :attachments
  has_many :comments
  # has_one :user

  def short_title
    object.title.truncate(10)
  end
end
