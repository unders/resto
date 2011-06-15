# encoding: utf-8

# https://tools.ietf.org/html/rfc3023
require 'resto/format'
require 'nokogiri'
require 'resto/extra/assert_hash.rb'

module Resto
  module Format

    # Used when sending and receiveing XML data.
    class Xml; end

    class << Xml
      include Format

      # The accept header when sending XML data.
      #
      # === Example:
      #  headers["accept"] = Resto::Format::Xml.accept
      #
      # @return [String] "application/xml, */*"
      def accept; 'application/xml, */*'; end

      # The content-type header when sending XML data.
      #
      # === Example:
      #  headers["content-type"] = Resto::Format::Xml.content_type
      #
      # @return [String] "application/xml;charset=utf-8"
      def content_type; 'application/xml;charset=utf-8'; end

      # Converts an XML formatted String to an Array of Hashes.
      #
      # === Example:
      #   xml = '<?xml version="1.0"?>
      #          <user>
      #            <name>Anders Törnqvist</name>
      #          </user>'
      #   Xml.decode(xml, :xpath => 'user')
      #     # => [{ 'user': { 'name': 'Anders Törnqvist' } }]
      #
      # @param xml [String]
      # @param [Hash] opts the options used when decoding the xml.
      # @option opts [String] :xpath the xpath to where the elements are found.
      #
      # @return [Array<Hash>]
      #
      def decode(xml, opts)
        xpath = AssertHash.keys(opts, :xpath).fetch(:xpath)

        doc =  Nokogiri::XML(xml)
        nodes =  doc.xpath(xpath)

        case nodes.size
        when 0
          [{}]
        when 1
          [elements_to_hash(nodes.first.children)]
        else
          nodes.map { |node| elements_to_hash(node.children) }
        end
      end

      # Converts a Hash to a XML formatted String.
      #
      # @param hash [Hash]
      # @param options is not used.
      #
      # === Example:
      #   Xml.encode({ root: { body: 'I am a body' } })
      #     # => "<?xml version=\"1.0\"?><root><body>I am a body</body></root>"
      #
      # @return [String]
      def encode(hash, options = nil)
        Nokogiri::XML::Builder.new { |xml| to_xml(hash, xml) }.to_xml
      end

      # The extension name used (if required) as the URL suffix.
      #
      # === Example:
      #   http://myhost.com:8085/bamboo/rest/api/latest/plan.xml
      #
      # @return [String] "xml"
      def extension; 'xml'; end

    private

      def elements_to_hash(children)
        attributes = {}

        children.each do |element|
          if element.is_a?(Nokogiri::XML::Element)
            attributes[element.name] = element.text
          end
        end

        attributes
      end

      #http://nokogiri.org/Nokogiri/XML/Builder.html
      def to_xml(hash, xml)
        hash.each do |key, value|
          xml.send("#{key.to_s}_") do
            if value.is_a?(Hash)
              to_xml(value, xml)
            else
              xml.text value if value
            end
          end
        end
      end
    end
  end
end
