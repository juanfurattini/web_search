# frozen_string_literal: true

# Base class for the SearchResult adapt
class SearchResultAdapterBase
  attr_reader :http_response, :body

  def initialize(http_response)
    @http_response = http_response
    @body = JSON.parse(http_response.body)
  end

  def adapt
    items_collection.map do |item|
      SearchResult.new(item[title_field_name], item[link_field_name], item[snippet_field_name])
    end
  end

  protected

  def items_collection
    raise NotImplementedError
  end

  def title_field_name
    raise NotImplementedError
  end

  def link_field_name
    raise NotImplementedError
  end

  def snippet_field_name
    raise NotImplementedError
  end
end
