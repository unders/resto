require 'resto/extra/valid_keys'

module Resto
  module Format
    class Xml; end

    class << Xml
      include Format
      def accept; 'application/xml, */*'; end
      def content_type; 'application/xml;charset=utf-8'; end

      def decode(xml, options)
        xpath = ValidKeys.new(:xpath).validate(options).fetch(:xpath)

        [Resto.xml_decode[xml, xpath]].flatten.compact
      end

      def encode(hash)
        Resto.xml_encode[hash.to_hash]
      end

      def extension; 'xml'; end
    end
  end
end
