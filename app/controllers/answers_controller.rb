class AnswersController < ApplicationController


    def create
      @question = Question.find(params[:question_id])
      @answer = @question.answers.new(answers_params)
      if @answer.save
        redirect_to @question
      else
        render 'questions/show'
      end

    end


    private
    def answers_params
      params.require(:answer).permit(:title, :body, :question_id)
    end
 
end
