# encoding: utf-8

require 'resto/request/base'
require 'resto/response/base'

module Resto

  # @note This module is used internally by these classes/modules:
  #  Resto::ClassMethods (see method {Resto::ClassMethods#request}, and
  #  {Resto::ClassMethods#base_response}). Resto::Request::Base
  #  (see method {Resto::Request::Base#construct_path}).
  #
  # This module has two helper methods that handles the process of copying the
  # {Resto::Request::Base} object and {Resto::Response::Base} object correctly.
  module Copy

    # Returns a copy of the {Resto::Request::Base} object.
    #
    # === Examples:
    #   Copy.request_base(request)
    #    # => new_request
    #
    # @param request_base [Request::Base]
    #
    # @return [Request::Base]
    def self.request_base(request_base)
      Resto::Request::Base.new.tap do |copy|
        copy_instance_variables(request_base, copy, ["@request"])

        request_klass = request_base.instance_variable_get("@request_klass")
        copy.instance_variable_set("@request", request_klass.new(copy))
      end
    end


    # Returns a copy of the {Resto::Response::Base} object.
    #
    # === Examples:
    #   Copy.response_base(response)
    #    # => new_response
    #
    # @param response_base [Response::Base]
    #
    # @return [Response::Base]
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
