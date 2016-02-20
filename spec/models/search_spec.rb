require 'rails_helper'

RSpec.describe Search, type: :model do

  CATEGORIES = ['Question', 'Answer', 'Comment', 'User']

  describe '.is_wrong' do
    it 'return true if search request is blank' do
      expect(Search.is_wrong?('All categories', '')).to eq true
    end


    it 'return true if search request contain non-existent category' do
      expect(Search.is_wrong?('un-existing', '123')).to eq true
    end

    CATEGORIES.each do |category|
      it 'return false if search has existent category end query' do
        expect(Search.is_wrong?(category, '123')).to eq false
      end
    end

    CATEGORIES.each do |category|
      it 'return false if search has existent category without query' do
        expect(Search.is_wrong?(category, '')).to eq false
      end
    end

  end


  describe '.search' do
    it 'should not receive search to ThinkingSphinx if search request is blank' do
      expect(ThinkingSphinx).to_not receive(:search)
      Search.search('All categories', '')
    end

    it 'should not receive search to ThinkingSphinx if search request is wrong' do
      expect(ThinkingSphinx).to_not receive(:search)
      Search.search('un-existing', '123')
    end

    it 'should receive search to ThinkingSphinx' do
      expect(ThinkingSphinx).to receive(:search).with('123')
      Search.search('All categories', '123')
    end

    CATEGORIES.each do |category|
      it "should receive search to #{category}" do
        expect(category.constantize).to receive(:search).with('123')
        Search.search(category, '123')
      end
    end

    CATEGORIES.each do |category|
      it "should receive search to #{category}" do
        expect(category.constantize).to receive(:search).with('')
        Search.search(category, '')
      end
    end
  end
end