class Api::V1:: AnswersController < Api::V1::BaseController
  def index
    @answers = Answer.all
    respond_with(@answers)
  end

  def show
    respond_with(@answer = Answer.find(params[:id]))
  end
end