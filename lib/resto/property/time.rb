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
        @format = options[:format]
        @delimiter = @format.to_s.match(/(\W)/) { |m| m[0] }
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
          if formatted_value.empty?
            nil
          else
            ::Time.parse(from_format(formatted_value))
          end
        rescue ArgumentError, TypeError, NoMethodError
          errors.store(@key, ":#{attribute_key} is not a valid time format.")
          nil
        end
      end

    private

      def from_format(value)
        if @format
          first_date_part = value.split("#{@delimiter}")

          reminder = first_date_part.delete_at(2)
          last = reminder.gsub(/\A(\d+)/) { $1 + "SPLIT" }.split("SPLIT")
          last_date_part = last[0]

          time_and_zone = last[1]
          date = first_date_part << last_date_part
          "#{date.at(year)}-#{date.at(month)}-#{date.at(day)}#{time_and_zone}"
        else
           value
        end
      end

      def to_format

      end

      def day
        split_format.index('dd')
      end

      def month
        split_format.index('mm')
      end

      def year
        split_format.index('yyyy')
      end

      def split_format
        @split_format ||= @format.split("#{@delimiter}")
      end

    end
  end
end
