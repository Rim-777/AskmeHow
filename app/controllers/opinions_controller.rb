class OpinionsController < ApplicationController
  before_action :set_openionable
  before_action :if_user_not_signed_in
  before_action :check_authorship

  respond_to do |format|
    format.json
    format.js
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

  def if_user_not_signed_in
    render nothing: true unless user_signed_in?

  end


  def check_authorship
    # format.json { render json: :author_error, status: :unprocessable_entity}
    render :author_error, status: :forbidden if current_user.author_of?(@opinionable)

  end

  def set_user_opinion(value)
    current_user.say_оpinion(@opinionable, value)
    render :opinion
  end

end