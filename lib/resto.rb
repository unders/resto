require "resto/version"
require "resto/request/settings"

module Resto
  # Resto.uri("http://example.com").get
  def self.uri(uri)
    Request::Settings.new.uri(uri)
  end
end
