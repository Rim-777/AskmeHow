class Search
  CATEGORIES = %w(All\ categories Question Answer Comment User )

  def self.search(category, query)
    unless Search.is_wrong?(category, query)
      search_area = category == 'All categories' ? ThinkingSphinx : category.constantize
      escaped_query = Riddle::Query.escape(query)
      search_area.search(escaped_query)
    end
  end

  def self.is_wrong?(category, query)
    self.is_not_valid?(category) || self.is_blank?(category, query)
  end


  private

  def self.is_not_valid?(category)
    !CATEGORIES.include?(category)
  end


  def self.is_blank?(category, query)
    !!(category == 'All categories' && query == '')
  end


end




