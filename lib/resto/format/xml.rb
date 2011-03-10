# encoding: utf-8

# https://tools.ietf.org/html/rfc3023

module Resto
  module Format
    class Xml; end

    class << Xml
      include Format

      def extension;       'xml';                           end
      def accept;          'application/xml, */*';          end
      def content_type;    'application/xml;charset=utf-8'; end

      def encode(hash, options = nil)

      end

      def decode(xml)

      end
    end
  end
end
