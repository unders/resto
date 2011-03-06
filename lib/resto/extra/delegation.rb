# encoding: utf-8

module Resto
  module Extra
    module Delegation

      def delegate(*methods)
        options = methods.pop
        to = options[:to]
        unless options.is_a?(Hash) && to
          raise ArgumentError, "Delegation needs a target. Supply an options
            hash with a :to key as the last argument
            (e.g. delegate :hello, :to => :greeter)."
        end

        methods.each do |method|
          class_eval <<-EOS
            def #{method}(*args, &block)
              #{to}.__send__(#{method.inspect}, *args, &block)
            end
          EOS
        end
      end
    end
  end
end
