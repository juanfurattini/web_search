# frozen_string_literal: true

# Base class for the search logic
class SearchBase
  INVALID_SEARCH_TERM_ERROR_MSG = 'Search term cannot be empty'

  attr_reader :term, :per_page, :page

  def initialize(term, per_page: 10, page: 1)
    @term = term
    @per_page = per_page || 10
    @page = page || 1

    validate!
  end

  def self.join(*results)
    [results].flatten.compact.uniq(&:link)
  end

  def search
    raise NotImplementedError
  end

  protected

  def escaped_term
    URI::Parser.new.escape(term)
  end

  private

  def validate!
    raise INVALID_SEARCH_TERM_ERROR_MSG if term.to_s.strip.blank?
  end
end