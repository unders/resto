module Resto
  module Format
    class Json; end

    class << Json
      include Format
      def accept; 'application/json, */*'; end
      def content_type; 'application/json'; end

      def decode(json)
        return [{}] if json.to_s.strip == ""
        [Resto.json_decode[json]].flatten.compact
      end

      def encode(hash)
        Resto.json_encode[hash.to_hash]
      end

      def extension; 'json'; end
    end
  end
end
