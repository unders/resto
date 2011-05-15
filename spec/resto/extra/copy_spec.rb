# encoding: utf-8

require 'spec_helper'
require 'resto/extra/copy'
describe Resto::Extra::Copy do
  describe ".request_base" do
    before do
      @request_base = Resto::Request::Base.new.port(40).
        url('http://www.aftonbladet.se:92/customers').
        query('q=adam').
        path('contacts')

      @new_request_base = Resto::Extra::Copy.request_base(@request_base).
        url('http://new.se:99/other').
        query('q=not-same').
        path('other-contacts/').
        headers({ "accept"=> "other", "user-agent"=> "Ruby" }).
        append_path(2)
    end

    it { @new_request_base.object_id.should_not == @request_base.object_id }
    it { @request_base.read_port.should == 40 }
    it { @request_base.composed_path.should  == '/contacts?q=adam' }

    it do
      @request_base.composed_headers.should  == { "accept"=> "*/*",
                                                  "user-agent"=> "Ruby" }
    end

    it do
      @request_base.composed_headers.object_id.should_not ==
        @new_request_base.composed_headers.object_id
    end

    it { @new_request_base.read_port.should == 40 }

    it do
      @new_request_base.composed_headers.should == {  "accept"=> "other",
                                                      "user-agent"=> "Ruby" }
    end

    it do
      @new_request_base.composed_path.should == "/other-contacts/2?q=not-same"
    end
  end

  describe ".response_base" do
    before do
      @response_base = Resto::Response::Base.new.format(:json)
      @new_response_base = Resto::Extra::Copy.response_base(@response_base).
        http_response('response')
    end

    it { @response_base.instance_eval { @response }.should == nil }
    it { @new_response_base.object_id.should_not  == @response_base.object_id }
    it { @new_response_base.instance_eval { @response }.should == 'response' }
  end
end
