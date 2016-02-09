class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question
  respond_to :js

  authorize_resource

  def create
   @subscription = @question.subscriptions.create(user: current_user) if @question.is_not_subscribed_with?(current_user)
   respond_with(@subscription)

  end

  def destroy
    @subscription = @question.subscriptions.find_by(user_id: current_user.id, question_id: @question.id)
    respond_with(@subscription.destroy) if @question.is_subscribed_with?(current_user)
  end


  private
  def set_question
    @question = Question.find(params[:question_id])
  end
end
