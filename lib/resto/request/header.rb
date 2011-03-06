# encoding: utf-8
require 'resto/format'

require 'resto/extra/hash_args'
class BasicAuth < Resto::Extra::HashArgs
  key :username
  key :password
end

class FormatExtension < Resto::Extra::HashArgs
  key :extension
end

module Resto
  module Request
    module Header

      def format(symbol, options=nil)
        formatter(Resto::Format.get(@symbol = symbol), options)
      end

      def formatter(formatter, options=nil)
        @add_extension = FormatExtension.new(options).fetch(:extension) { false }
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
        options = BasicAuth.new(options)

        basic_encode = 'Basic ' + ["#{options.fetch(:username)}:#{options.fetch(:password)}"].pack('m').delete("\r\n")
        tap { composed_headers.store('authorization', basic_encode) }
      end
    end
  end
end
