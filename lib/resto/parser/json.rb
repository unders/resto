# encoding: utf-8
require 'json' # 2. e.g. require 'yajl'

# This file is not required when Resto is required.
#
# - If you work with a JSON API, require this file and everything will work.
#   require 'resto/parser/json' 
#
# OR
#
# - If you want to parse JSON with another library, e.g the yajl gem.
#  You can create your own file and require that one instead, as long
#  as that file only change line 2, 22, and 26.
#  require 'path/to/your/file'

module Resto
  module Parser
    module Json
      module_function

      def decode(json)
        JSON.parse(json) # 22. e.g. Yajl::Parser.parse(json) 
      end

      def encode(hash)
        JSON.dump(hash) # 26. e.g. Yajl::Encoder.encode(hash)
      end
    end
  end
end
