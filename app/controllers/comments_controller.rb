class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_commentable, only: :create

  authorize_resource

  respond_to :js
  respond_to :json

  def create
    respond_with( @comment = @commentable.comments.create(comment_params.merge!(user_id: current_user.id)), location: @commentable)
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

  def interpolation_options
    {resource_name: 'New Comment', time: @comment.created_at}

  end
end


