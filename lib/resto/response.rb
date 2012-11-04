class Resto::Response
  attr_reader :http_response, :header, :code, :raw_body, :location

  def http_response(http_response)
    @http_response = http_response
    @header = @http_response.to_hash
    @code = @http_response.code
    @raw_body = @http_response.body
  end

  def success?
    (/\A2\d{2}\z/ =~ @code) == 0
  end

  def redirect?
    (/\A3\d{2}\z/ =~ @code) == 0
  end

  def error?
    not (success? or redirect?)
  end

  def location
    @header["location"]
  end
end
