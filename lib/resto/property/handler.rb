# encoding: utf-8
module Resto
  module Property
    class Handler
      def initialize
        @properties = {} # TODO fix indifferent access
        @properties_with_indifferent_access = {}
      end

      def add(property)
        @properties_with_indifferent_access.store(property.remote_key, property)
        @properties_with_indifferent_access
          .store(property.attribute_key, property)
        @properties_with_indifferent_access
          .store(property.attribute_key_as_string, property)

        @properties.store(property.attribute_key, property)
      end

      def attribute_key(key)
        get(key, 'attribute_key')
      end

      def remote_attributes(attributes)
        remote_attributes = {}

        attributes.each do |key, value|
          remote_key = get(key, 'remote_key') || key
          remote_attributes[remote_key] = value
        end

        remote_attributes
      end

      def cast(key, value, errors)
        get(key).cast(value, errors)
      end

      def validate(resource)
        @properties.each do |key, property|
          property.validate(resource, key)
        end
      end

    private
      def get(key, method=nil)
        property = @properties_with_indifferent_access.fetch(key, false)

        if (property and method)
          property.send(method)
        else
          property
        end
      end
    end
  end
end
