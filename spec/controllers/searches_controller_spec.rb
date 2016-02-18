require 'rails_helper'

RSpec.describe SearchesController, type: :controller do

  describe 'GET #search' do
    let!(:query) { '123' }
    CATEGORIES = ['Question', 'Answer', 'Comment', 'User']

    it 'should not send  message :search to  ThinkingSphinx to' do
      expect(ThinkingSphinx).to_not receive(:search)
      get :search, category: 'All categories', query: '', format: :js
    end


    it 'should send  message search to ThinkingSphinx to' do
      expect(ThinkingSphinx).to receive(:search).with(query)
      get :search, category: 'All categories', query: query, format: :js
    end


    CATEGORIES.each do |category|
      it "should send  message search to #{category}" do
        expect(category.constantize).to receive(:search).with(query)
        get :search, category: category, query: query, format: :js
      end
    end


  end
end

