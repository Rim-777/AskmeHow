class SearchesController < ApplicationController
  skip_authorization_check
  before_action :check_search_validation
  protect_from_forgery except: :search
  respond_to :js

  def search
   @search_result = category.search(query)
   respond_with(@search_result)
  end

  private
  def category
    params[:category] == 'All categories' ? ThinkingSphinx : params[:category].constantize
  end

  def check_search_validation
    redirect_to 'questions/index' if category == ThinkingSphinx && query == ''
  end

  def query
    params[:query]
  end

end
