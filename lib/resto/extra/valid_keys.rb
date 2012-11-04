class ValidKeys
  def initialize(*keys)
    @valid_keys = keys
  end

  def validate(hash)
    hash.each_key do |k|
      fail(ArgumentError, "Unknown key: #{k}") unless @valid_keys.include?(k)
    end
    hash
  end
end

