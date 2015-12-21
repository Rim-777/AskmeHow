class OpinionsController < ApplicationController
  before_action :set_openionable

  def positive
    current_user.say_оpinion(@opinionable, 1)
    render 'questions/show'#todo временно для теста
  end

  def negative
    current_user.say_оpinion(@opinionable, -1)
    render 'questions/show'#todo временно для теста
  end


private

  def set_openionable
    klass = params[:opinionable_type].to_s.capitalize.constantize
    @opinionable = klass.find(params[:opinionable_id])
  end
end

