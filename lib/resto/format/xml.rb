# encoding: utf-8

# https://tools.ietf.org/html/rfc3023
require 'resto/format'
require 'nokogiri'

module Resto
  module Format
    class Xml; end

    class << Xml
      include Format

      def extension;       'xml';                           end
      def accept;          'application/xml, */*';          end
      def content_type;    'application/xml;charset=utf-8'; end

      def encode(hash, options = nil)
        Nokogiri::XML::Builder.new { |xml| to_xml(hash, xml) }.to_xml
      end

      def decode(xml, options)
        xpath = options.fetch(:xpath)

        doc =  Nokogiri::XML(xml)
        nodes =  doc.xpath(xpath)

        case nodes.size
        when 0
          {}
        when 1
          elements_to_hash(nodes.first.children)
        else
          nodes.map { |node| elements_to_hash(node.children) }
        end
      end

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
