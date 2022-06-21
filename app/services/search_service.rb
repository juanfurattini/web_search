# frozen_string_literal: true

# This service class handles the web search.
# It receives the search engine to use and the search term.
# If the search engine is invalid, or if the search term is blank,
# it raises an error.
# If the search engine is both, it will call google and bing engines
# to search, join the results, and removing the duplicated results
# (results that are present in both engine results)
class SearchService
  GOOGLE_SEARCH_ENGINE = 'google'
  BING_SEARCH_ENGINE = 'bing'
  BOTH_SEARCH_ENGINES = 'both'

  VALID_SEARCH_ENGINES = [GOOGLE_SEARCH_ENGINE, BING_SEARCH_ENGINE, BOTH_SEARCH_ENGINES].freeze

  ENGINE_SEARCH_CLASS = {
    GOOGLE_SEARCH_ENGINE => Google::Search,
    BING_SEARCH_ENGINE => Bing::Search,
    BOTH_SEARCH_ENGINES => [Google::Search, Bing::Search]
  }.freeze

  INVALID_SEARCH_ENGINE_ERROR_MSG = 'Invalid search engine. ' \
                                    "Only #{VALID_SEARCH_ENGINES.to_sentence} are allowed".freeze

  INVALID_SEARCH_TERM_ERROR_MSG = 'Search term cannot be empty'

  attr_reader :engine, :text

  def initialize(engine, text)
    @engine = engine.to_s
    @text = text.to_s

    validate_params!
  end

  def search
    # Performs the search for the used engines in threads to avoid increasing execution time
    # when multiple search engines are used (both)
    executions = [ENGINE_SEARCH_CLASS[engine]].flatten.map do |search_class|
      Thread.new { Thread.current[:search_results] = search_class.new(text).search }
    end
    results = executions.map do |execution|
      execution.join
      execution[:search_results]
    end
    SearchBase.join(results)
  end

  def validate_params!
    raise INVALID_SEARCH_ENGINE_ERROR_MSG if VALID_SEARCH_ENGINES.exclude? engine
    raise INVALID_SEARCH_TERM_ERROR_MSG if text.to_s.strip.blank?
  end
end


