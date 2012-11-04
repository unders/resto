# encoding: utf-8
require "uri"

module Resto
  module Format
    class WwwForm; end

    class << WwwForm
      include Format

      def accept;              'application/x-www-form-urlencoded, */*'; end
      def content_type;        'application/x-www-form-urlencoded';      end
      def decode(string); [Hash[URI.decode_www_form(string.to_s)]];      end
      def encode(params); URI.encode_www_form(params || {});             end
    end
  end
end
