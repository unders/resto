# encoding: utf-8

require 'resto/extra/delegation'
require 'resto/request/uri'
require 'resto/request/header'
require 'resto/request/option'
require 'resto/request/factory'
require 'resto/translator/request_factory'
require 'resto/extra/copy'

module Resto
  module Request
    class Base
      extend  Resto::Extra::Delegation
      include Resto::Request::Header
      include Resto::Request::Uri
      include Resto::Request::Option

      delegate :head, :get, :post, :put, :delete, :to => :@request

      def initialize(request=Resto::Request::Factory)
        @request_klass = request
        @request = @request_klass.new(self)
      end

      def construct_path(options)
        new_path = @path.clone

        @path_substitute_keys.each do |substitute|
          new_path.gsub!(/:#{substitute}/, options[substitute].to_s)
        end

        Extra::Copy.request_base(self).path(new_path)
      end

      def url(url)
        tap { parse_url(url) }
      end

      def host(host)
        tap { @host = host }
      end

      def port(port)
        tap { @port = port }
      end

      def path(path)
        @path = path
        keys = path.scan(/\/(:\w+)/).flatten
        @path_substitute_keys = keys.map {|key| key.gsub(/:/, "").to_sym }
        self
      end

      def append_path(append_path)
        tap { @append_path = append_path }
      end

      def query(query)
        tap { @query = query }
      end

      def params(hash)
        tap { @params = hash }
      end

      def body(body)
        tap { @body = body }
      end

      def translator(translator)
        @translator = Resto::Translator::RequestFactory.create(translator)
        self
      end

      def read_body
        if @body
          body = @translator ? @translator.call(@body) : @body
          current_formatter.encode(body)
        end
      end

      def current_formatter
        @formatter ||= Resto::Format.get(@symbol || :default)
      end
    end
  end
end
