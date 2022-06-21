# frozen_string_literal: true

def with_modified_env(**env_overrides)
  # Mock ENV to be allowed to assert if some key was readed
  allow(ENV).to receive(:[]).and_call_original

  # If there is no block to execute it doesn't do anything
  return unless block_given?

  # Mock the desired keys with the passed key/values
  normalize_overrides(**env_overrides).each_pair do |key, value|
    allow(ENV).to receive(:[]).with(key).and_return value
  end

  # Execute the spec block
  yield
ensure
  # Remove all the mocks
  RSpec::Mocks.space.proxy_for(ENV).reset
end

private

def normalize_overrides(**env_overrides)
  env_overrides.transform_keys(&:to_s).transform_values(&:to_s)
end
