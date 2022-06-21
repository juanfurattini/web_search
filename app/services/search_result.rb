# frozen_string_literal: true

# PORO class to store the search result item
class SearchResult
  attr_reader :title, :link, :snippet

  def initialize(title, link, snippet)
    @title = title
    @link = link
    @snippet = snippet
  end
end