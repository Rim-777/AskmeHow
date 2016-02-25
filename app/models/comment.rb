class Comment < ActiveRecord::Base
  after_create :publish_comment
  belongs_to :user

  belongs_to :commentable, polymorphic: true
  validates :body, :commentable_id, :commentable_type, :user_id, presence: true

  default_scope { order(created_at: :desc)}

private

  def set_chanel_for
    "/question/#{commentable_type == 'Question' ? commentable_id : commentable.question_id}/comments"
  end

  def data_for_chanel
    {comment: to_json, author_of_comment: user.email.to_json}
  end

  def publish_comment
    PrivatePub.publish_to set_chanel_for, data_for_chanel if errors.empty?
  end


  end
