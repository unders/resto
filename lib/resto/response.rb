class Resto::Response
  def http_response(http_response)
    @http_response = http_response
  end

  def success?
    (/\A2\d{2}\z/ =~ code) == 0
  end

  def redirect?
    (/\A3\d{2}\z/ =~ code) == 0
  end

  def error?
    not (success? or redirect?)
  end

  def code
    @http_response ? @http_response.code : nil
  end

  def raw_body
    @http_response ? @http_response.body : nil
  end
end
