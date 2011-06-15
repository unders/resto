# encoding: utf-8

module Resto

  # @note This class is only used internally.
  #
  # AssertHash validates that a Hash only contain valid keys. The purpose
  # is to assert that methods are used with correct arguments.
  class AssertHash

    # Asserts that keys in the Hash is valid. It also converts
    # String keys to Symbol keys.
    #
    # === Examples:
    #  hash = { :valid => 'I am valid' }
    #  AssertHash.keys(hash, :valid)
    #   # => { :valid => 'I am valid'}
    #
    #  hash = { 'valid' => 'I am valid' }
    #  AssertHash.keys(hash, :valid)
    #   # => { :valid => 'I am valid'}
    #
    #  hash = { :invalid => 'I am invalid' }
    #  AssertHash.keys(hash, :valid)
    #   # => raises ArgumentError
    #
    # @param hash [Hash]
    # @param *valid_keys [Symbol, Symbol, ...]
    #
    # @return [Hash] string keys are converted to their corresponding Symbols.
    #
    # @raise [ArgumentError] if the Hash contains unknown key(s).
    def self.keys(hash, *valid_keys)
      hash ||= {}

      hash.each { |key, value| hash[key.to_sym] = hash.delete(key) }

      known_keys = [valid_keys].flatten
      unknown_keys = hash.keys - known_keys
      unless unknown_keys.empty?
        unknown = "Invalid key(s): #{unknown_keys.join(", ")}"
        known = "Valid key(s): #{known_keys.join(", ")}"
        raise(ArgumentError, "#{unknown} \n #{known}")
      end

      hash
    end
  end
end
