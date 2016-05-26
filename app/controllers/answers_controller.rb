class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :destroy]
  before_action :set_question, only: :create
  before_action :set_answer, except: :create
  authorize_resource

  respond_to :js
  respond_to :json, only: :create

  def create
    respond_with(@answer = @question.answers.create(answers_params.merge!(user_id: current_user.id)))
  end

  def update
    @answer.update(answers_params) if current_user.author_of?(@answer)
    respond_with(@answer)
  end

  def destroy
    respond_with(@answer.destroy) if current_user.author_of?(@answer)
  end

  def select_best
    respond_with(@answer.set_is_best) if current_user.author_of?(@answer.question)
  end

  private
  def answers_params
    params.require(:answer).permit(:body, :question_id, attachments_attributes: [:file, :id, :_destroy])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def interpolation_options
    {resource_name: 'New Answer', time: @answer.created_at}
  end
end
