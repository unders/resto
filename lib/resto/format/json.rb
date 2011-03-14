# encoding: utf-8

# http://en.wikipedia.org/wiki/JSON
require 'yajl'

module Resto
  module Format
    class Json; end

    class << Json
      include Format

      def extension;       'json';                   end
      def accept;          'application/json, */*';  end
      def content_type;    'application/json';       end

      def encode(hash, options = nil)
        raise ArgumentError unless hash.is_a?(Hash)

        Yajl::Encoder.encode(hash)
      end

      def decode(json, options=nil)
        raise ArgumentError unless json.is_a?(String)

        Yajl::Parser.parse(json)
      end
    end
  end
end
