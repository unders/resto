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

      def format(symbol, options = {})
        xpath = options[:xpath]
        xpath(xpath) if xpath
        formatter(Resto::Format.get(@symbol = symbol))
      end

      def xpath(xpath)
        tap { @xpath = xpath }
      end

      def read_xpath
        @xpath || "//#{@klass.to_s.downcase}"
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
        body ? current_formatter.decode(body, :xpath => read_xpath) : nil
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

      def valid?
        (/\A20\d{1}\z/ =~ code.to_s) == 0
      end

      def all
        return self unless @translator

        body = read_body.is_a?(Hash) ? [read_body] : read_body

        (body || []).map do |hash|
          @translator.call(@klass, hash).tap do |instance|
            instance.response = self
          end
        end
      end

    end
  end
end
