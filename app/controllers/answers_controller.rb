class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :destroy]
  before_action :set_question, only: [:create]
  before_action :set_answer, except: [:create]


  def create
    @answer = @question.answers.new(answers_params)
    current_user.is_author_of!(@answer)
    @answer.save

  end

  def update
    # @question = @answer.question
    @answer.update(answers_params) if current_user.author_of?(@answer)

  end

  def destroy
    @answer.destroy if current_user.author_of?(@answer)

  end

  def select_best
    if current_user.author_of?(@answer.question)
      @question = @answer.question
      @answer.set_is_best
    end
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
end
