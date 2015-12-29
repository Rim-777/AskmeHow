class CommentsController < ApplicationController
  before_action :set_commentable
  respond_to do |format|
    format.js
    format.json
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    current_user.is_author_of!(@comment) if user_signed_in?
    if @comment.save
      PrivatePub.publish_to "/question/#{@commentable.id}/comments", comment: @comment.to_json
    end
      render nothing: true

  end


  private

  def set_commentable
    commentable_class = params[:commentable].classify.constantize
    commentable_object = "#{params[:commentable].singularize}_id".to_sym
    commentable_id = params[commentable_object]
    @commentable = commentable_class.find(commentable_id)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end


