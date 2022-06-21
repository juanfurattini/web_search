# frozen_string_literal: true

describe Google::SearchResultAdapter, type: :service do
  let(:response_hash) do
    {
      items: [
        {
          kind: 'customsearch#result',
          title: 'EE363: Lecture Slides - Stanford',
          htmlTitle: 'EE363: <b>Lecture</b> Slides - Stanford',
          link: 'https://stanford.edu/class/ee363/lectures.html',
          displayLink: 'stanford.edu',
          snippet: "These lecture slides are still changing, so don't print them yet." \
                   'Linear quadratic regulator: Discrete-time finite horizon · LQR via Lagrange multipliers.',
          htmlSnippet: 'These <b>lecture</b> slides are still changing, so don&#39;t print them yet.' \
                       'Linear quadratic regulator: Discrete-time finite horizon &middot;' \
                       'LQR via Lagrange multipliers.',
          cacheId: 'QocOKS12VuoJ',
          formattedUrl: 'https://stanford.edu/class/ee363/lectures.html',
          htmlFormattedUrl: 'https://stanford.edu/class/ee363/<b>lectures</b>.html',
          labels: [
            {
              name: 'lectures',
              displayName: 'Lectures',
              label_with_op: 'more:lectures'
            }
          ]
        }
      ]
    }
  end

  let(:http_response) do
    double('Net::HTTPSuccess', body: response_hash.to_json)
  end

  describe '#adapt' do
    let(:instance) { described_class.new(http_response) }

    it 'returns a SearchResult object with the proper values' do
      result = instance.adapt
      expect(result).to be_an Array
      item = result.first
      expect(item).to be_a SearchResult
      expect(item.title).to eq response_hash[:items].first[:title]
      expect(item.link).to eq response_hash[:items].first[:link]
      expect(item.snippet).to eq response_hash[:items].first[:snippet]
    end
  end
end
