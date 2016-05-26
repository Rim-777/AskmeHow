class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :update, :destroy]
  before_action :set_answer, only: :show
  respond_to :json, only: :create
  respond_to :js, except: :destroy

  authorize_resource

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with(@question)
  end

  def new
    respond_with(@question = Question.new)
  end

  def create
    respond_with(@question = Question.create(questions_params.merge!(user_id: current_user.id)))
  end

  def update
    @question.update(questions_params) if current_user.author_of?(@question)
    respond_with(@question)
  end

  def destroy
    @question.destroy if current_user.author_of?(@question)
    respond_with (@question) do |format|
      format.html { redirect_to questions_path }
    end
  end

  private
  def set_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file, :id, :_destroy])
  end

  def set_answer
    @answer = @question.answers.new if @question
  end

  def interpolation_options
    {resource_name: 'New Question', time: @question.created_at}
  end
end