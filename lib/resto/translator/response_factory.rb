# encoding: utf-8

require 'resto/translator/request_factory'
module Resto
  module Translator
    class ResponseFactory < Factory

      def call(klass, hash)
        hash ||= {}
        raise ArgumentError unless hash.is_a?(Hash)

        klass.new(traverse(hash, 0))
      end

    private

      def traverse(hash, index)
        next_hash = hash[@keys.at(index)] || hash[@keys.at(index).to_s]

        if next_hash
          traverse(next_hash, index + 1)
        else
          hash
        end
      end
    end
  end
end
