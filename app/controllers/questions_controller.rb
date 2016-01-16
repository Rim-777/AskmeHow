class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :update, :destroy]
  before_action :set_answer, only: :show
  after_action :publish_question, only: [:create]

  respond_to :json, only: :create
  respond_to :js, except: :destroy


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
    redirect_to questions_path
    # respond_with(@question.destroy) if current_user.author_of?(@question)
    # respond_with(@question)
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

  def publish_question
    PrivatePub.publish_to "/questions", question: render_to_string(partial: 'questions/question_data.json.jbuilder')
  end

  def interpolation_options
    {resource_name: 'New Question', time: @question.created_at}

  end
end
