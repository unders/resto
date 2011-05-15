# encoding: utf-8

require 'time'

module Resto
  module Property
    class Time; end

    class << Time
    end

    class Time
      include Property

      def initialize(name, options={})
        @key = (name.to_s + "_time").to_sym
        super
      end

      def cast(value, errors)
        errors.store(@key, nil)

        formatted_value = value.to_s.strip
        if formatted_value.gsub(/([a-z|A-Z]{1,5}\Z)/, '') =~ /[^T\d\-:\+\/\s]/
          errors.store(@key, ":#{attribute_key} is not a valid time format.")
          formatted_value = ""
        end

        number_of_digits = formatted_value.gsub(/\D/, '').length
        if (1..9).include?(number_of_digits)
          errors.store(@key, ":#{attribute_key} is not a valid time format.")
          formatted_value = ""
        end

        begin
          formatted_value.empty? ? nil : ::Time.parse(formatted_value)
        rescue ArgumentError, TypeError
          errors.store(@key, ":#{attribute_key} is not a valid time format.")
          nil
        end
      end
    end
  end
end
