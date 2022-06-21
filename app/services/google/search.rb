# frozen_string_literal: true

module Google
  # This class handles the web search using the google custom search api v1
  class Search < SearchBase
    ENDPOINT = 'https://www.googleapis.com/customsearch/v1'

    def search
      uri = URI(ENDPOINT)
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)

      unless response.is_a? Net::HTTPSuccess
        error_message = JSON.parse(response.body).dig('error', 'message')
        raise "Error occurred when calling Google Search API: #{error_message}"
      end

      SearchResultAdapter.new(response).adapt
    end

    private

    def params
      {
        key: ENV['GOOGLE_CUSTOM_SEARCH_API_KEY'],
        cx: ENV['GOOGLE_PROGRAMMABLE_SEARCH_ENGINE_ID'],
        q: escaped_term,
        num: per_page,
        start: ((page - 1) * per_page) + 1
      }
    end
  end
end
