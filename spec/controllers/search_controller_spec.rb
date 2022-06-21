# frozen_string_literal: true

describe SearchController, type: :controller do
  describe '#search' do
    let(:json_response) { JSON.parse(response.body).with_indifferent_access }
    let(:valid_search_engines) { %w[google bing both] }
    let(:valid_search_term) { 'Ruby on Rails' }

    shared_examples 'api error' do
      it 'renders error response' do
        get :search, params: { engine: search_engine, text: search_term }

        expect(json_response[:success]).to be false
        expect(json_response[:message]).to eq 'API Error'
        expect(json_response[:error]).to eq error_message
        expect(response).to have_http_status(500)
      end
    end

    context 'when search engine is not valid' do
      it_behaves_like 'api error' do
        let(:search_engine) { 'foobar' }
        let(:search_term) { valid_search_term }
        let(:error_message) { 'Invalid search engine. Only google, bing, and both are allowed' }
      end
    end

    context 'when search term is blank' do
      it_behaves_like 'api error' do
        let(:search_engine) { valid_search_engines.sample }
        let(:search_term) { nil }
        let(:error_message) { 'Search term cannot be empty' }
      end
    end

    context 'when params are valid' do
      shared_examples 'a valid response' do
        before do
          allow(Google::Search).to receive(:new).with(search_term).and_return google_engine
          allow(google_engine).to receive(:search).and_return nil
          allow(Bing::Search).to receive(:new).with(search_term).and_return bing_engine
          allow(bing_engine).to receive(:search).and_return nil

          get :search, params: { engine: search_engine, text: search_term }
        end

        let(:search_term) { valid_search_term }
        let(:google_engine) { Google::Search.new(search_term) }
        let(:google_calls) { %w[google both].include?(search_engine) ? 1 : 0 }
        let(:bing_engine) { Bing::Search.new(search_term) }
        let(:bing_calls) { %w[bing both].include?(search_engine) ? 1 : 0 }

        it 'calls the right search engine' do
          expect(Google::Search).to have_received(:new).with(search_term).exactly(google_calls).times
          expect(google_engine).to have_received(:search).exactly(google_calls).times
          expect(Bing::Search).to have_received(:new).with(search_term).exactly(bing_calls).times
          expect(bing_engine).to have_received(:search).exactly(bing_calls).times
        end

        it 'renders the json response' do
          expect(json_response[:success]).to be true
          expect(json_response[:message]).to eq 'API Response'
          expect(json_response[:error]).to be_an Array
          expect(response).to have_http_status(200)
        end
      end

      context 'when search engine is google' do
        it_behaves_like 'a valid response' do
          let(:search_engine) { 'google' }
        end
      end

      context 'when search engine is bing' do
        it_behaves_like 'a valid response' do
          let(:search_engine) { 'bing' }
        end
      end

      context 'when search engine is both' do
        it_behaves_like 'a valid response' do
          let(:search_engine) { 'both' }
        end
      end
    end
  end
end
