# frozen_string_literal: true

module Bing
  # This class handles the web search using the bing search api v7
  class Search < SearchBase
    ENDPOINT = 'https://api.cognitive.microsoft.com/bing/v7.0/search'

    def search
      uri = URI(ENDPOINT)
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri, headers)

      unless response.is_a? Net::HTTPSuccess
        error_message = JSON.parse(response.body).dig('error', 'message')
        raise "Error occurred when calling Bing Search API: #{error_message}"
      end

      SearchResultAdapter.new(response).adapt
    end

    private

    def params
      {
        q: escaped_term,
        count: per_page,
        offset: ((page - 1) * per_page)
      }
    end

    def headers
      {
        'Ocp-Apim-Subscription-Key' => ENV['BING_SEARCH_API_KEY']
      }
    end
  end
end
