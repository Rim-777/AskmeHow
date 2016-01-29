class Api::V1::QuestionsController < Api::V1::BaseController
  skip_authorization_check

  def index
    @questions = Question.all
    # respond_with(@questions.to_json(include: :answers ))
    respond_with(@questions)
  end
end