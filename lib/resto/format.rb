# encoding: utf-8

require 'resto/format/default'
require 'resto/format/plain'
require 'resto/format/json'
require 'resto/format/xml'

module Resto

  # @note This module is only used internally by the classes mentioned below.
  #
  # {Resto::Request::Base} (see method {Resto::Request::Header#format})
  # uses this module.
  #
  # {Resto::Response::Base} (see method {Resto::Response::Base#format})
  # uses this module.
  #
  #== Add a Format
  #
  # If a user of Resto wants to handle a format different from whats
  # available, she can create a class in the Format module. Then
  # include the Format module into the meta class and override the methods
  # that she want to change. See example below.
  #
  # === Example:
  #   module Resto
  #     module Format
  #       class Foo; end
  #
  #       class << Foo
  #         include Format
  #
  #         def extension;         'foo'           end
  #         def accept;            'foo';          end
  #       end
  #     end
  #   end
  #
  #
  module Format

    # Returns the class that corresponds to the symbol argument.
    #
    # === Examples:
    #  Resto::Format.get(:json)
    #   # => Resto::Format::Json
    #
    #  Resto::Format.get(:xml)
    #   # => Resto::Format:Xml
    #
    # @param symbol [Symbol]
    # @return [Format] a class who implements the Format interface.
    #
    # @raise [NameError] if the class doesn't exist.
    def self.get(symbol=:default)
      Resto::Format.const_get("#{symbol.to_s.capitalize}")
    end

    # The accept header. This method is overriden by the classes
    # that includes this module if they want a different accept header.
    #
    # @return [String] "*/*"
    def accept; '*/*'; end

    # The content-type header. This method is overriden by the classes
    # that includes this module if they want a different content-type header.
    #
    # @return [nil]
    def content_type; end

    # Returns the first argument. This method is overriden by classes that
    # includes this module if they want a different behavior.
    #
    # @return [Object] the first argument.
    def decode(*args); args.first end

    # Returns the first argument. This method is overriden by classes that
    # includes this module if they want a different behavior.
    #
    # @return [Object] the first argument.
    def encode(*args); args.first end

    # The extension. This method is overriden by the classes
    # that includes this module if they want to have an extension.
    #
    # @return [nil]
    def extension; end
  end
end
