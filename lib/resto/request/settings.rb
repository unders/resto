require "resto/request"
require "resto/request/header"
require "resto/request/uri"

class Resto::Request::Settings
  extend Forwardable
  include Resto::Request::Header
  include Resto::Request::Uri

  def_delegators :@request, :get, :get!

  def initialize(request = Resto::Request)
    @headers = Hamster.hash('accept'=> '*/*' , 'user-agent'=> 'Ruby')
    @uri = nil
    @request = request.new(self)
    @response = nil
  end

  def read_response
    @response
  end

  def response(response)
    tap { @response = response }
  end
end
