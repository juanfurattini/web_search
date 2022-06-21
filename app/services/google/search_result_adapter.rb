# frozen_string_literal: true

module Google
  # This class adapts the google api search result into our SearchResult PORO class.
  # The base structure of the search result is this:
  # {
  #   "items": [
  #     {
  #       "kind": "customsearch#result",
  #       "title": "EE363: Lecture Slides - Stanford",
  #       "htmlTitle": "EE363: <b>Lecture</b> Slides - Stanford",
  #       "link": "https://stanford.edu/class/ee363/lectures.html",
  #       "displayLink": "stanford.edu",
  #       "snippet": "These lecture slides are still changing, so don't print them yet. Linear quadratic regulator: Discrete-time finite horizon · LQR via Lagrange multipliers.",
  #       "htmlSnippet": "These <b>lecture</b> slides are still changing, so don&#39;t print them yet. Linear quadratic regulator: Discrete-time finite horizon &middot; LQR via Lagrange multipliers.",
  #       "cacheId": "QocOKS12VuoJ",
  #       "formattedUrl": "https://stanford.edu/class/ee363/lectures.html",
  #       "htmlFormattedUrl": "https://stanford.edu/class/ee363/<b>lectures</b>.html",
  #       "labels": [
  #         {
  #           "name": "lectures",
  #           "displayName": "Lectures",
  #           "label_with_op": "more:lectures"
  #         }
  #       ]
  #     },
  #   ]
  # }
  class SearchResultAdapter < SearchResultAdapterBase
    def items_collection
      body.fetch('items', [])
    end

    def title_field_name
      'title'
    end

    def link_field_name
      'link'
    end

    def snippet_field_name
      'snippet'
    end
  end
end