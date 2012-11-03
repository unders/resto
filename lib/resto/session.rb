require "resto/response"
require 'forwardable'

class Resto::Session
  extend Forwardable

  def_delegators :response, :code, :raw_body
  alias raw_response_body raw_body

  attr_reader :http, :request, :response, :http_response, :request_body

  def initialize(options)
    @http  = options.fetch(:http)
    @request = options.fetch(:request)
    @response = options[:response] || Resto::Response.new
    @request_body = options[:request_body]

    @http_response = @http.request(@request, @request_body)
    @response.http_response(@http_response)
  end

  def finish
    @http.finish if @http.started?
  end
end
