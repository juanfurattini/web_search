# frozen_string_literal: true

describe Google::Search, type: :service do
  around do |example|
    VCR.use_cassette(cassette_name, record: :new_episodes, match_requests_on: %i[method uri body headers]) do
      example.run
    end
  end

  describe '#search' do
    let(:instance) { described_class.new(term, per_page: 1, page: 1) }
    let(:term) { 'Google Search' }

    context 'when api key is invalid' do
      let(:cassette_name) { 'google_search_failure' }
      let(:error_msg) do
        'Error occurred when calling Google Search API: API key not valid. Please pass a valid API key.'
      end

      it 'raises an error' do
        with_modified_env(GOOGLE_CUSTOM_SEARCH_API_KEY: 'invalid_value') do
          expect { instance.search }.to raise_error error_msg
        end
      end
    end

    context 'when search is valid' do
      let(:cassette_name) { 'google_search_success_1_item' }

      it 'validates the result' do
        result = instance.search
        expect(result).to be_a Array
        expect(result).to all be_a SearchResult
      end
    end
  end
end
