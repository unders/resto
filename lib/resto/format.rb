# encoding: utf-8

require 'resto/format/default'
require 'resto/format/plain'
require 'resto/format/json'
require 'resto/format/xml'

module Resto
  module Format
    def self.get(symbol=:default)
      format = Resto::Format.const_get("#{symbol.to_s.capitalize}")
      Resto::Format.const_get("#{symbol.to_s.capitalize}")
    end

    def extension;                         end
    def accept;            '*/*';          end
    def content_type;                      end
    def encode(*args);    args.first       end
    def decode(*args);    args.first       end
  end
end
