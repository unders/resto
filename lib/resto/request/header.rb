require 'hamster'
#require 'resto/extra/valid_keys'
require 'resto/format'

module Resto::Request::Header
  def format(symbol, options={})
    formatter(Resto::Format.const_get(symbol.capitalize), options)
  end

  def formatter(formatter, options={})
    #ValidKeys.new(:extension).validate(options)
    @formatter = formatter
    accept(@formatter.accept)
    content_type(@formatter.content_type)
  end

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
