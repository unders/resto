require "resto/session"
require "net/http"

class Resto::Request
  def initialize(settings, session_class = Resto::Session)
    @settings, @session_class = settings, session_class
  end

  def get
    close_connection_after { get! }
  end

  def get!
    new_session :Get
  end

  private

  def read_settings
    @headers     = @settings.read_headers
    @response    = @settings.read_response
    @body        = nil #@settings.read_body
    uri          = @settings.read_uri
    @request_uri = uri.request_uri
    @host        = uri.host
    @port        = uri.port
  end

  def new_session(verb)
    read_settings
    request = Net::HTTP.const_get(verb).new(@request_uri, @headers)
    @session = @session_class.new http: setup_http,
                                  request: request,
                                  response: @response,
                                  request_body: @body
  end

  def close_connection_after
    begin
      yield
    ensure
      @session.finish
    end
  end

  def setup_http
    Net::HTTP.new(@host, @port).tap do |http|

      #@settings.use_ssl if @uri.scheme == "https"

     # unless @sessions.options.keys.empty?
     #   http.methods.grep /\A(\w+)=\z/ do |name|
     #     key = $1.to_sym
     #     @sessions.options.key?(key) or next
     #     http.__send__ name, options[key]
     #   end
     # end
    end
  end
end
