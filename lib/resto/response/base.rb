# encoding: utf-8

require 'resto/format'
require 'resto/translator/response_factory'

module Resto
  module Response
    class Base

      def klass(klass)
        tap { @klass = klass }
      end

      def translator(translator)
        @translator = Resto::Translator::ResponseFactory.create(translator)
        self
      end

      def format(symbol)
        formatter(Resto::Format.get(@symbol = symbol))
      end

      def formatter(formatter)
        tap { @formatter = formatter }
      end

      def current_formatter
        @formatter ||= Resto::Format.get(@symbol || :default)
      end

      def http_response(response)
        tap { @response = response }
      end

      def read_body
        body ? current_formatter.decode(body) : nil
      end

      def body
        @response ? @response.body : nil
      end

      def code
        @response ? @response.code : nil
      end

      attr_reader :response

      def get
        return self unless @translator

        @translator.call(@klass, read_body).tap do |instance|
          instance.response = self
        end
      end

      def all
        return self unless @translator

        (read_body || []).map do |hash|
          @translator.call(@klass, hash).tap do |instance|
            instance.response = self
          end
        end
      end

    end
  end
end
