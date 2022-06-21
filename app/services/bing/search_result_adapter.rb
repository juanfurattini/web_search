# frozen_string_literal: true

module Bing
  # This class adapts the bing api search result into our SearchResult PORO class.
  # The base structure of the search result is this:
  # "webPages": {
  #   "value": [
  #     {
  #       "id": "https://api.cognitive.microsoft.com/api/v7/#WebPages.0",
  #       "name": "Microsoft Cognitive Services",
  #       "url": "https://www.microsoft.com/cognitive-services",
  #       "displayUrl": "https://www.microsoft.com/cognitive-services",
  #       "snippet": "Knock down barriers between you and your ideas. Enable natural and contextual interaction with tools that augment users' experiences via the power of machine-based AI. Plug them in and bring your ideas to life.",
  #       "deepLinks": [
  #         {
  #           "name": "Face",
  #           "url": "https://azure.microsoft.com/services/cognitive-services/face/",
  #           "snippet": "Add facial recognition to your applications to detect, identify, and verify faces using the Face service from Microsoft Azure. ... Cognitive Services; Face service;"
  #         },
  #         {
  #           "name": "Text Analytics",
  #           "url": "https://azure.microsoft.com/services/cognitive-services/text-analytics/",
  #           "snippet": "Cognitive Services; Text Analytics API; Text Analytics API . Detect sentiment, ... you agree that Microsoft may store it and use it to improve Microsoft services, ..."
  #         },
  #         {
  #           "name": "Computer Vision API",
  #           "url": "https://azure.microsoft.com/services/cognitive-services/computer-vision/",
  #           "snippet": "Extract the data you need from images using optical character recognition and image analytics with Computer Vision APIs from Microsoft Azure."
  #         },
  #         {
  #           "name": "Emotion",
  #           "url": "https://www.microsoft.com/cognitive-services/en-us/emotion-api",
  #           "snippet": "Cognitive Services Emotion API - microsoft.com"
  #         },
  #         {
  #           "name": "Bing Speech API",
  #           "url": "https://azure.microsoft.com/services/cognitive-services/speech/",
  #           "snippet": "Add speech recognition to your applications, including text to speech, with a speech API from Microsoft Azure. ... Cognitive Services; Bing Speech API;"
  #         },
  #         {
  #           "name": "Get Started for Free",
  #           "url": "https://azure.microsoft.com/services/cognitive-services/",
  #           "snippet": "Add vision, speech, language, and knowledge capabilities to your applications using intelligence APIs and SDKs from Cognitive Services."
  #         }
  #       ]
  #     }
  #   ]
  # }
  class SearchResultAdapter < SearchResultAdapterBase
    def items_collection
      body.dig('webPages', 'value') || []
    end

    def title_field_name
      'name'
    end

    def link_field_name
      'url'
    end

    def snippet_field_name
      'snippet'
    end
  end
end