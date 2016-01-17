class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_commentable, only: :create
  after_action :publish_comment, only: :create


  respond_to :js
  respond_to :json


  def create
    @comment = @commentable.comments.new(comment_params.merge!(user_id: current_user.id))
    @comment.save
    respond_with(@commentable, @comment, location: @commentable)

  end


  private

  def set_commentable
    commentable_class = params[:commentable].capitalize.constantize
    commentable_object = "#{params[:commentable].singularize}_id".to_sym
    commentable_id = params[commentable_object]
    @commentable = commentable_class.find(commentable_id)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_chanel_for
    "/question/#{@commentable.class == Question ? @commentable.id : @commentable.question_id}/comments"
  end

  def data_for_chanel
    {comment: @comment.to_json, author_of_comment: @comment.user.email.to_json}
  end

  def publish_comment
    PrivatePub.publish_to set_chanel_for, data_for_chanel if @comment.errors.empty?
  end

  def interpolation_options
    {resource_name: 'New Comment', time: @comment.created_at}

  end
end


