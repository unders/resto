# encoding: utf-8
require 'resto/format'
require 'resto/extra/assert_hash'

module Resto
  module Request
    module Header

      def format(symbol, options=nil)
        formatter(Resto::Format.get(@symbol = symbol), options)
      end

      def formatter(formatter, options=nil)
        options = AssertHash.keys(options, :extension)
        @add_extension = options.fetch(:extension) { false }
        @formatter = formatter
        accept(formatter.accept)
        content_type(formatter.content_type)
      end

      def composed_headers
        @headers ||= { 'accept'=> '*/*' , 'user-agent'=> 'Ruby' }
      end

      def headers(headers)
        tap { composed_headers.merge!(headers) }
      end

      def accept(accept)
        tap { composed_headers.store('accept', accept) }
      end

      def content_type(content_type)
        tap { composed_headers.store('content-type', content_type) }
      end

      def basic_auth(options)
        options = AssertHash.keys(options, :username, :password)

        username = options.fetch(:username)
        password = options.fetch(:password)
        base64_encode = ["#{username}:#{password}"].pack('m').delete("\r\n")
        basic_encode = 'Basic ' + base64_encode

        tap { composed_headers.store('authorization', basic_encode) }
      end
    end
  end
end
