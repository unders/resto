# encoding: utf-8

module Resto
  class Attributes
    def initialize(attributes, resource, property_handler = nil)
      @resource = resource
      @property_handler = property_handler || resource.class.property_handler
      @attributes = {} # TODO must handle indifferent access :name and 'name'
      @attributes_before_cast = {}
      @errors = {}

      update_attributes(attributes)
    end

    def update_attributes(attributes)
      attributes.each do |key, value|
        key = @property_handler.attribute_key(key)
        set(key, value) if key
      end
    end

    def set(key, value)
      @attributes_before_cast.store(key, value)
      @attributes.store(key, @property_handler.cast(key, value, @errors))
    end

    def get(key)
      @attributes.fetch(key, nil)
    end

    def get_without_cast(key)
       @attributes_before_cast.fetch(key, nil)
    end

    def present?(key)
      @attributes.fetch(key, false) ? true : false
   end

    def valid?
      @property_handler.validate(@resource)
      errors.empty?
    end

    def add_error(key, value)
      @errors.store(key, value)
    end

    def errors
      @errors.map {|key, value| value }.compact
    end

    def to_hash
      @attributes.merge({})
    end
  end
end
