class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_commentable

  respond_to do |format|
    format.js
    format.json
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    current_user.is_author_of!(@comment) if user_signed_in?
    PrivatePub.publish_to set_chanel_for(@commentable), data_for_chanel if @comment.save
    render nothing: true
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

  def set_chanel_for(commentable)
    commentable_class = commentable.class
    if commentable_class == Question
      "/question/#{@commentable.id}/comments"
    elsif commentable_class == Answer
      "/question/#{@commentable.question_id}/answers/comments"
    end
  end

  def data_for_chanel
    {comment: @comment.to_json, author_of_comment: @comment.user.email.to_json}
  end
end


