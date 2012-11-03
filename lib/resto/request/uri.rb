module Resto::Request::Uri
  def read_uri
    URI(@uri.to_s)
  end

  def uri(uri)
    uri = uri.to_s
    unless uri[/\Ahttps?:\/\//]
      raise ArgumentError, "The scheme: (http:// | https://) must be included."
    end
    tap { @uri = URI(uri) }
  end

  def query(query)
    tap { @uri.query = query }
  end

  def params(params)
    current_query = Hash[URI.decode_www_form(@uri.query.to_s)]
    tap { @uri.query = URI.encode_www_form(current_query.merge(params)) }
  end
end
