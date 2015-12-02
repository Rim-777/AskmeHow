class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :set_question, only: [:show, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
  end

  def new
    @question = Question.new
  end


  def create
    @question = Question.new(questions_params)
    current_user.is_author_of!(@question)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def update
     @question.update(questions_params) if current_user.author_of?(@question)
  end

  def destroy
    @question.destroy if current_user.author_of?(@question)
    redirect_to questions_path
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body)
  end
end
