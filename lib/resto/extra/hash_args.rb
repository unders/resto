# encoding: utf-8

class Resto::Extra::HashArgs; end

class << Resto::Extra::HashArgs

  def key(key)
    @keys ||= []

    unless key.is_a?(Symbol)
      raise ArgumentError, "The key '#{key}' must be a symbol"
    end

    if @keys.include?(key)
      raise ArgumentError, "The key '#{key}' has already been defined."
    end

    @keys << key
  end

private
  def assert_key(key)
    unless @keys.include?(key.to_sym)
      raise ArgumentError, "The key '#{key}' is not valid.
        Valid keys are: #{@keys.join(' ,')}"
    end
  end
end

class Resto::Extra::HashArgs

  def initialize(hash)
    hash ||= {}
    raise ArgumentError, "'#{hash}' must be a Hash" unless hash.is_a?(Hash)
    keys = hash.keys
    keys_as_symbols = keys.map(&:to_sym)
    if (keys_as_symbols.uniq.size != keys_as_symbols.size)
      raise ArgumentError, "duplicated keys: #{keys.join(', ')}"
    end

    @hash = {}
    keys.each do |key|
      self.class.send(:assert_key, key)
      @hash[key.to_sym] = hash.fetch(key)
    end
  end

  def fetch(key, &block)
    self.class.send(:assert_key, key)
    @hash.fetch(key, &block)
  end

  def keys
    @hash.keys
  end
end
