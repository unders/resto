# encoding: utf-8

module Resto
  module Log
    def self.print_request(request, settings)
      url = ["#{settings.method} #{settings.scheme}://#{settings.read_host}"]
      url[0] += "#{settings.composed_path}:#{settings.read_port}"
      out(title("Request"), url, content(request, settings))
    end

    def self.print_response(response, settings)
      out(["\n"], title("Response"), content(response, settings))
    end

    def self.title(title)
      out = []
      out << "\n==============================="
      out << "          #{title.upcase}"
      out << "==============================="
    end

    def self.content(result, settings)
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
      if settings.current_formatter == Resto::Format::Json and not body.empty?
        body = Yajl::Encoder.encode(Format::Json.decode(body),
                                    { :pretty => true, :indent => "  " })
      end
      out << "\n*** Body (#{length}) ***\n#{body}"
    end

    def self.out(*out)
      puts (out.fetch(0, []) + out.fetch(1, []) + out.fetch(2, [])).join("\n")
    end
  end
end
