# encoding: utf-8
require 'uri'
require 'cgi'

module Resto
  module Request
    module Uri
      def read_host
        return nil unless @host

        normalize_uri(@host)
        @uri.host
      end

      def read_port; @port ||= 80; end

      def composed_path
        path    = ["/#{@path}", @append_path].compact.join('/').gsub('//', "/")
        path    = "#{path}.#{current_formatter.extension}" if @add_extension
        params = hash_to_params
        return path unless (@query or params)

        [path, [@query, params].compact.join('&')].join('?')
      end

      attr_reader :scheme
      def normalize_uri(url)
        @uri = URI.parse(url.match(/^https?:/) ? url : "http://#{url}")
        @scheme ||= @uri.scheme
        @host   ||= @uri.host
        @port   ||= @uri.port
        @path   ||= @uri.path
        @query  ||= @uri.query
      end

      def parse_url(url)
        normalize_uri(url)
      end

      def hash_to_params
        return nil unless @params
        raise ArgumentError unless @params.is_a?(Hash)

        @params.sort.map do |a|
          "#{CGI.escape(a.fetch(0).to_s)}=#{CGI.escape(a.fetch(1).to_s)}"
        end.join('&')
      end
    end
  end
end
