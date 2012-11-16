require "resto/version"
require "resto/request/settings"

module Resto
  class << self
    attr_accessor :json_decode, :json_encode

    def uri(uri)
      Request::Settings.new.uri(uri)
    end

    def configure
      yield self
    end
  end

  Resto.configure do |config|
    config.json_decode = ->(json) { JSON.parse(json) }
    config.json_encode = ->(hash) { JSON.dump(hash) }
  end
end

