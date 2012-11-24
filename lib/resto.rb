require "resto/version"
require "resto/request/settings"

module Resto
  class << self
    attr_accessor :json_decode, :json_encode,
                  :xml_decode, :xml_encode

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
    config.xml_decode = ->(xml, xpath) { Resto::Parser::Xml.decode(xml, xpath) }
    config.xml_encode = ->(hash) { Resto::Parser::Xml.encode(hash) }
  end
end

