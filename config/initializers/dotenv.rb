# frozen_string_literal: true

REQUIRED_ENV_KEYS = %w[
  GOOGLE_CUSTOM_SEARCH_API_KEY
  GOOGLE_PROGRAMMABLE_SEARCH_ENGINE_ID
  BING_SEARCH_API_KEY
].freeze


Dotenv.require_keys(*REQUIRED_ENV_KEYS) if defined?(Dotenv)
