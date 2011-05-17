# encoding: utf-8

require 'net/https'
require 'resto/extra/delegation'

module Resto
  module Request
    class Factory
      extend Resto::Extra::Delegation

      delegate :read_host, :read_port, :options, :read_body, :composed_path,
        :composed_headers, :scheme, :use_ssl, :current_formatter,
        :to => :@request

      def initialize(request)
        @request = request
        @debug_request = false
      end

      def head!
        @debug_request = true
        head.tap { |response| print_response(response) }
      end

      def head
        http.start do |http|
          request = Net::HTTP::Head.new(composed_path, composed_headers)
          print_request(request)
          http.request(request)
        end
      end

      def get!
        @debug_request = true
        get.tap { |response| print_response(response) }
      end

      def get
        http.start do |http|
          request = Net::HTTP::Get.new(composed_path, composed_headers)
          print_request(request)
          http.request(request)
        end
      end

      def post!
        @debug_request = true
        post.tap { |response| print_response(response) }
      end

      def post
        http.start do |http|
          request = Net::HTTP::Post.new(composed_path, composed_headers)
          print_request(request)
          http.request(request, read_body)
        end
      end

      def put!
        @debug_request = true
        put.tap { |response| print_response(response) }
      end

      def put
        http.start do |http|
          request = Net::HTTP::Put.new(composed_path, composed_headers)
          print_request(request)
          http.request(request, read_body)
        end
      end

      def delete!
        @debug_request = true
        delete.tap { |response| print_response(response) }
      end

      def delete
        http.start do |http|
          request = Net::HTTP::Delete.new(composed_path, composed_headers)
          print_request(request)
          http.request(request)
        end
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

      def print_request(request)
        if @debug_request
          url = ["#{request.method} #{scheme}://#{read_host}"]
          url[0] += "#{request.path}:#{read_port}"
          out(title("Request"), url, content(request))
        end
      end

      def print_response(response)
        if @debug_request
          out(["\n"], title("Response"), content(response))
        end
      end

      def title(title)
        out = []
        out << "\n==============================="
        out << "          #{title.upcase}"
        out << "==============================="
      end

      def content(result)
        out = []
        result.each_header do |key, value|
          if key == "status"
            out.unshift("header['#{key}'] : #{value}")
          else
            out.push("header['#{key}'] : #{value}")
          end
        end
        out.unshift("\n*** Header ***")

        body = result.body.to_s
        length = body.length
        if current_formatter == Resto::Format::Json and not body.empty?
          body = Yajl::Encoder.encode(Format::Json.decode(body),
                                      { :pretty => true, :indent => "  " })
        end
        out << "\n*** Body (#{length}) ***\n#{body}"
      end

      def out(*out)
        puts (out.fetch(0, []) + out.fetch(1, []) + out.fetch(2, [])).join("\n")
      end
    end
  end
end
