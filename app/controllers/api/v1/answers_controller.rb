class Api::V1:: AnswersController < Api::V1::BaseController
  before_action :set_question, only: :create
  authorize_resource

  def index
    @answers = Answer.all
    respond_with(@answers)
  end

  def show
    respond_with(@answer = Answer.find(params[:id]))
  end

  def create
    respond_with current_resource_owner.answers.create(answer_params.merge(question_id: @question.id))
  end


  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end