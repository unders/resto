# encoding: utf-8

require 'resto/request/base'
require 'resto/response/base'

module Resto
  module Extra
    module Copy

      def self.request_base(request_base)
        Resto::Request::Base.new.tap do |copy|
          copy_instance_variables(request_base, copy, ["@request"])

          request_klass = request_base.instance_variable_get("@request_klass")
          copy.instance_variable_set("@request", request_klass.new(copy))
        end
      end

      def self.response_base(response_base)
        Resto::Response::Base.new.tap do |copy|
          copy_instance_variables(response_base, copy, ["@response"])
        end
      end

      def self.copy_instance_variables(from, to, exclude = [])
        (from.instance_variables.map(&:to_s) - exclude).each do |name|
          instance_variable = from.instance_variable_get(name)

          to.instance_variable_set(name, instance_variable)
        end
      end
    end
  end
end
