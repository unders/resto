# encoding: utf-8

require 'resto/extra/log'

module Resto
  class Session

    attr_reader :request, :response

    def initialize(settings)
      @request_settings = settings
    end

    def add_request(request)
      tap { @request =  request }
    end

    def add_response(response)
      tap { @response =  response }
    end

    def code
      response_message :code
    end

    def valid?
      (/\A20\d{1}\z/ =~ code.to_s) == 0
    end

    def body
      response_message :body
    end

    def print
      Log.print_request(@request, @request_settings)
      Log.print_response(@response, @request_settings)
    end

  private

    def response_message(symbol)
      @response ? @response.send(symbol) : nil
    end

  end
end
