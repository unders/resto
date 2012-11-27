require "rspec"
require "resto"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  if 'java' == RUBY_PLATFORM
    config.filter_run_excluding :not_on_jruby => true
  else
    config.filter_run_excluding :only_jruby => true
  end
end
