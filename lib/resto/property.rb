# encoding: utf-8

require 'resto/validate'
require 'resto/property/handler'
require 'resto/property/string'
require 'resto/property/integer'
require 'resto/property/time'

module Resto
  module Property

    def initialize(name, options={})
      raise ':name must be a symbol' unless name.is_a?(Symbol)

      @name = name
      @remote_name = options.fetch(:remote_name) { name }
      @validations = []
    end

    def remote_key
      @remote_name.to_s
    end

    def attribute_key
      @name
    end

    def attribute_key_as_string
      @name.to_s
    end

    def validate_presence
      Validate::Presence.new.tap { |validation| @validations.push(validation) }
    end

    def validate_inclusion
      Validate::Inclusion.new.tap { |validation| @validations.push(validation) }
    end

    def validate_length
      Validate::Length.new.tap { |validation| @validations.push(validation) }
    end

    def validate(resource, attribute_key)
      @validations.each do |validate|
        validate.attribute_value(resource, attribute_key)
      end
    end
  end
end
