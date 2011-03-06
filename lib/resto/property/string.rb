# encoding: utf-8

module Resto
  module Property
    class String; end

    class << String
    end

    class String
      include Property

      def cast(value, errors=nil)
        value.to_s
      end
    end

  end
end
