class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: :create


  def create
    @answer = @question.answers.new(answers_params)
    current_user.is_author_of!(@answer)
    @answer.save

  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy if current_user.author_of?(@answer)
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
