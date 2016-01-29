class Api::V1:: AnswersController < Api::V1::BaseController
  def index
    @answers = Answer.all
    respond_with(@answers)
  end
end