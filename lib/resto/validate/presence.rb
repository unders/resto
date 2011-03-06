# encoding: utf-8

module Resto
  module Validate
    class Presence
      include Validate

      def attribute_value(resource, attribute_method)

        error_key = (attribute_method.to_s + "_presence").to_sym
        value_before_cast = resource.send("#{attribute_method}_without_cast")

        error =
          if (validate?(resource) && value_before_cast.to_s.strip.empty?)
            ":#{attribute_method} #{@message || "can’t be blank"}"
          else
            nil
          end

        resource.add_error(error_key, error)
      end
    end
  end
end
