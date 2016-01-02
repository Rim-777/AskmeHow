class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  before_action :set_question, only: [:show, :update, :destroy]

  respond_to do |format|
    format.html
    format.js
    format.json
  end

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
    @answer.attachments.new
  end

  def new
    @question = Question.new
    @question.attachments.new
  end


  def create
    @question = Question.new(questions_params)
    current_user.is_author_of!(@question)
    if @question.save
      PrivatePub.publish_to "/questions", question: render_to_string(partial: 'questions/question_data.json.jbuilder')

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
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end
end
