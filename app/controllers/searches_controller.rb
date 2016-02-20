class SearchesController < ApplicationController
  skip_authorization_check
  before_action :check_search_validation
  protect_from_forgery except: :search
  respond_to :js

  def search
    @search_result = Search.search(params[:category], params[:query])
    respond_with(@search_result)
  end

  private
  def check_search_validation
   render nothing: true if Search.is_wrong?(params[:category], params[:query])
  end
end
