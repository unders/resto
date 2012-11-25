require "rexml/document"

module Resto
  module Parser
    class Xml; end

    class << Xml
      def decode(xml, xpath)
        Decode.new(xml, xpath).to_array.tap do |array| 
          array << {} if array.empty?
        end
      end

      def encode(hash)
        return "" unless hash
        return "" if hash.empty?
        xml = Encode.new(hash, REXML::Document.new).to_xml
        %Q[<?xml version="1.0" encoding="UTF-8"?>#{xml}]
      end

      class Decode < Struct.new(:xml, :xpath)
        def to_array
          doc = REXML::Document.new(xml)

          REXML::XPath.match(doc, xpath).map do |item| 
            item.elements.each_with_object({}) do |element, hash| 
              hash[element.name] = element.text
            end
          end
        end
      end

      class Encode < Struct.new(:hash, :doc)
        def to_xml
          hash.each do |key, value|
            if value.is_a?(Hash)
              element = REXML::Element.new(key.to_s)
              doc.add_element(element)
              Encode.new(value, element).to_xml
            elsif value.is_a?(Array)
              value.each { |hash| Encode.new({ key => hash }, doc).to_xml }
            else
              element = REXML::Element.new(key.to_s).add_text(value.to_s)
              doc.add_element(element)
            end
          end
          doc
        end
      end
    end
  end
end
