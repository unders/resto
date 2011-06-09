# encoding: utf-8

require 'yajl'

module Resto
  module Format
    # @note This class is only used internally by the classes mentioned below.
    #
    # {Resto::Request::Base} (see method {Resto::Request::Header#formatter})
    # uses this class to create a valid JSON request.
    #
    # {Resto::Response::Base} (see method {Resto::Response::Base#read_body})
    # uses this class to convert a JSON formatted String to a Hash.
    class Json; end

    class << Json
      include Format
      # The accept header when sending JSON data.
      #
      # === Example:
      #  headers["accept"] = Resto::Format::Json.accept
      #
      # @return [String] "application/json, */*"
      def accept; 'application/json, */*'; end

      # The content-type header when sending JSON data.
      #
      # === Example:
      #  headers["content-type"] = Resto::Format::Json.content_type
      #
      # @return [String] "application/json"
      def content_type; 'application/json'; end

      # Converts a JSON formatted String to a Hash.
      #
      # === Example:
      #   Json.decode("{\"root\":{\"body\":\"I am a body\"}}")
      #     # => { root: { body: 'I am a body' } }
      #
      # @param json [String]
      # @param options is not used.
      #
      # @return [Hash]
      def decode(json, options=nil)
        raise ArgumentError unless json.is_a?(String)

        Yajl::Parser.parse(json)
      end

      # Converts a Hash to a JSON formatted String.
      #
      # @param hash [Hash]
      # @param options is not used.
      #
      # === Example:
      #   Json.encode({ root: { body: 'I am a body' } })
      #     # => "{\"root\":{\"body\":\"I am a body\"}}"
      #
      # @return [String]
      def encode(hash, options = nil)
        raise ArgumentError unless hash.is_a?(Hash)

        Yajl::Encoder.encode(hash)
      end

      # The extension name used (if required) as the URL suffix.
      #
      # === Example:
      #   http://myhost.com:8085/bamboo/rest/api/latest/plan.json
      #
      # @return [String] "json"
      def extension; 'json'; end
    end
  end
end
