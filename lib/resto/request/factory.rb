# encoding: utf-8

require 'net/https'
require 'resto/extra/delegation'

module Resto
  module Request
    class Factory
      extend Resto::Extra::Delegation

      delegate :read_host, :read_port, :options, :read_body, :composed_path,
        :composed_headers, :scheme, :use_ssl, :to => :@request

      def initialize(request)
        @request = request
      end

      def head
        http.start do |http|
          http.request(Net::HTTP::Head.new(composed_path, composed_headers))
        end
      end

      def get
        http.start do |http|
          http.request(Net::HTTP::Get.new(composed_path, composed_headers))
        end
      end

      def post
        http.start do |http|
          http.request(Net::HTTP::Post.new(composed_path, composed_headers),
                       read_body)
        end
      end

      def put
        http.start do |http|
          http.request(Net::HTTP::Put.new(composed_path, composed_headers),
                       read_body)
        end
      end

      def delete
        http.start do |http|
          http.request(Net::HTTP::Delete.new(composed_path, composed_headers))
        end
      end

      def http
        ::Net::HTTP.new(read_host, read_port).tap do |http|

          use_ssl if scheme == "https"

          unless options.keys.empty?
            http.methods.grep(/\A(\w+)=\z/) do |meth|
              key = $1.to_sym
              options.key?(key) or next
              http.__send__(meth, options[key])
            end
          end
        end
      end
    end
  end
end
