# encoding: utf-8

module Resto
  module Format

    # This class is used when sending plain text requests.
    class Plain; end

    class << Plain
      include Format

      # The accept header when sending text data.
      #
      # === Example:
      #  headers["accept"] = Resto::Format::Plain.accept
      #
      # @return [String] "text/plain, */*"
      def accept;        'text/plain, */*';   end


      # The content-type header when sending text data.
      #
      # === Example:
      #  headers["content-type"] = Resto::Format::Plain.content_type
      #
      # @return [String] "text/plain"
      def content_type;  'text/plain';        end
    end
  end
end
