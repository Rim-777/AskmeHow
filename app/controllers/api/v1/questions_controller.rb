class Api::V1::QuestionsController < Api::V1::BaseController
  authorize_resource class: Question

  def index
    @questions = Question.all
    # respond_with(@questions.to_json(include: :answers ))
    respond_with(@questions)
  end

  def show
    respond_with Question.find(params[:id])
  end

  def create
    respond_with current_resource_owner.questions.create(questions_params)
  end


  private
  def questions_params
    params.require(:question).permit(:title, :body)
  end
end