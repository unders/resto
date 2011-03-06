# encoding: utf-8

module Resto
  module Format
    class Plain; end

    class << Plain
      include Format

      def accept;        'text/plain, */*';   end
      def content_type;  'text/plain';        end
    end
  end
end
