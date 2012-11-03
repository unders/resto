require 'hamster'

module Resto::Request::Header
  def read_headers
    @headers
  end

  def headers(headers)
    tap { @headers = read_headers.merge(headers) }
  end

  def accept(accept)
    tap { @headers = read_headers.put('accept', accept) }
  end

  def content_type(content_type)
    tap { @headers = read_headers.put('content-type', content_type) }
  end

  def basic_auth(options)
    username = options.fetch(:username)
    password = options.fetch(:password)

    base64_encode = ["#{username}:#{password}"].pack('m').delete("\r\n")
    basic_encode = 'Basic ' + base64_encode

    tap { @headers = read_headers.put('authorization', basic_encode) }
  end
end
