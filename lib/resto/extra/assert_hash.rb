# encoding: utf-8

class AssertHash

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
