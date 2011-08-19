# encoding: utf-8

require 'net/https'
require 'forwardable'
require 'resto/session'

module Resto
  module Request
    class Factory
      extend Forwardable

      def_delegators :@request_setting, :read_host, :read_port, :options,
                     :read_body, :composed_path, :composed_headers, :scheme,
                     :use_ssl

      def initialize(request_setting)
        @request_setting = request_setting
        @session = Session.new(@request_setting)
      end

      def head
        @request_setting.method(:head)

        response = http.start do |http|
          request = Net::HTTP::Head.new(composed_path, composed_headers)
          @session.add_request(request)
          http.request(request)
        end

        @session.add_response(response)
      end

      def get
        @request_setting.method(:get)

        response = http.start do |http|
          request = Net::HTTP::Get.new(composed_path, composed_headers)
          @session.add_request(request)
          http.request(request)
        end

        @session.add_response(response)
      end

      def post
        @request_setting.method(:post)

        response = http.start do |http|
          request = Net::HTTP::Post.new(composed_path, composed_headers)
          @session.add_request(request)
          http.request(request, read_body)
        end

        @session.add_response(response)
      end

      def put
        @request_setting.method(:put)

        response = http.start do |http|
          request = Net::HTTP::Put.new(composed_path, composed_headers)
          @session.add_request(request)
          http.request(request, read_body)
        end

        @session.add_response(response)
      end

      def delete
        @request_setting.method(:delete)

        response = http.start do |http|
          request = Net::HTTP::Delete.new(composed_path, composed_headers)
          @session.add_request(request)
          http.request(request)
        end

        @session.add_response(response)
      end

    private

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
