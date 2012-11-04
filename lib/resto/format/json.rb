module Resto
  module Format
    class Json; end

    class << Json
      include Format

      @@message = [ "The module Resto::Parser::Json is not defined.",
                   "- If you want to parse a JSON string with Resto, you can",
                   "require 'resto/parser/json'.",
                   "OR",
                   "- You can create your own Resto::Parser::Json module.",
                   "Look at file 'resto/parser/json.rb' for how to do it.",
                   ""
                  ].join("\n           ")

      def accept; 'application/json, */*'; end
      def content_type; 'application/json'; end

      def decode(json)
        if defined?(Resto::Parser::Json)
          [Resto::Parser::Json.decode(json.to_s)].flatten.compact
        else
          fail NameError, @@message
        end
      end

      def encode(hash)
        if defined?(Resto::Parser::Json)
          Resto::Parser::Json.encode(hash || {})
        else
          fail NameError, @@message
        end
      end

      def extension; 'json'; end
    end
  end
end
