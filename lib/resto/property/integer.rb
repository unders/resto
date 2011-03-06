# encoding: utf-8

module Resto
  module Property
    class Integer; end

    class << Integer
    end

    class Integer
      include Property

      def initialize(name, options={})
        @key = (name.to_s + "_integer").to_sym
        super
      end

      def cast(value, errors)
        errors.store(@key, nil)

        begin
          value.to_s.strip.empty? ? nil : Integer(value)
        rescue ArgumentError, TypeError
          nil.tap { errors.store(@key, ":#{attribute_key} is not an integer.") }
        end
      end
    end
  end
end
