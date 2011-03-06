# encoding: utf-8

module Resto
  module Translator
    class Factory; end

    class << Factory
      def create(translator)
        if translator.is_a?(Symbol) and :default == translator
          new([])
        elsif translator.is_a?(Array)
          new(translator)
        elsif translator.is_a?(Proc)
          translator
        elsif translator.is_a?(Class)
          translator.new
        else
          raise(ArgumentError,
                "Invalid argument. Valid symbol is :default. Array, Class or a
                Proc is also a valid translator.")
        end
      end
    end

    class Factory
      def initialize(keys)
        @keys = keys
      end
    end

    class RequestFactory < Factory

      def call(attributes)
        attributes ||= {}
        raise ArgumentError unless attributes.is_a?(Hash)

        @keys.reverse.inject(attributes) do |memo, item|
          Hash.new.tap {|h| h[item] = memo }
        end
      end

    end
  end
end
