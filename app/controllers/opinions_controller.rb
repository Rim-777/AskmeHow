class OpinionsController < ApplicationController
  before_action :set_openionable

  respond_to do |format|
    format.json
  end

  def positive
    set_user_opinion(1)
  end


  def negative
    set_user_opinion(-1)
  end


  private

  def set_openionable
    type = params[:opinionable_type].to_s.capitalize.constantize
    @opinionable = type.find(params[:opinionable_id])
  end


  def set_user_opinion(value)
    if user_signed_in? && current_user.not_author_of?(@opinionable)
      current_user.say_оpinion(@opinionable, value)
      render :opinion
    else
      render nothing: true
    end
  end
end

