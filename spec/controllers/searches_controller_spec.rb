require 'rails_helper'

RSpec.describe SearchesController, type: :controller do

  describe 'GET #search' do
  let!(:query) { '123' }
      it 'should calculate user reputation after create' do
        expect(ThinkingSphinx).to receive(:search).with(query)
        get :search, category: 'All categories', query:  query, format: :js
      end

  end
end

