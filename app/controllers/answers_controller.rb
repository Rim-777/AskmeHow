class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: :create


  def create
    @answer = @question.answers.new(answers_params)
    @answer.user = current_user
   if @answer.save
    redirect_to @question
    else#todo
      render 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy if @answer.user_id == current_user.id
    redirect_to @answer.question
  end

  private
  def answers_params
    params.require(:answer).permit(:body, :question_id)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

end
