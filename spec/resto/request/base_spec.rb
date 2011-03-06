# encoding: UTF-8

require 'spec_helper'
require 'yajl'
require 'resto/request/base'

describe Resto::Request::Base do

  context "Resto::Request::Base.new" do

    its(:composed_headers) do
      should == {  "accept"=> "*/*", "user-agent"=> "Ruby" }
    end

    its(:current_formatter)    { should == Resto::Format::Default }

    its(:read_host)            { should == nil }
    its(:read_port)            { should == 80  }
    its(:composed_path)        { should == '/' }

    describe "@request" do
      it do
        subject.instance_eval { @request }
          .should be_instance_of(Resto::Request::Factory)
      end
    end
  end

  describe "#content_type('application/x-www-form-urlencoded')" do

    before { subject.content_type('application/x-www-form-urlencoded') }

    its(:composed_headers) do
      should == { 'content-type' => 'application/x-www-form-urlencoded',
                  "accept"=> "*/*", "user-agent"=> "Ruby" }
    end
  end

  context "#content_type('text/html').headers({'content-type' => 'text/plain',
                                               'User-agent' => 'Ruby' })" do
    before do
      subject.content_type('text/html')
        .headers({'content-type' => 'text/plain', 'user-agent' => 'Ruby' })
    end

    its(:composed_headers) do
      should == { 'content-type' => 'text/plain',
                  "accept"=> "*/*",
                  "user-agent"=> "Ruby" }
    end
  end

  context "#basic_auth('username' => 'developer', 'password' => 'secret')
            .content_type('text/html')" do

    before do
      subject.basic_auth('username' => "developer", "password" => "secret")
        .content_type('text/html')
    end

    its(:composed_headers) do

      should == { 'authorization' => basic_encode('developer', 'secret'),
                  'content-type' => 'text/html',
                  "accept"=> "*/*",
                  "user-agent"=> "Ruby" }
    end
  end

  context "#basic_auth('username' => 'developer', 'password' => 'secret')
            .headers('content-type' => 'text/plain')" do

    before { subject.headers('content-type' => 'text/plain') }

    its(:composed_headers) do
      should == { 'content-type' => 'text/plain',
                  "accept"=> "*/*",
                  "user-agent"=> "Ruby" }
    end
  end

  context "#url('www.aftonbladet.se/')" do

    before { subject.url('www.aftonbladet.se/') }

    its(:read_host)     { should == 'www.aftonbladet.se' }
    its(:read_port)     { should == 80 }
    its(:composed_path) { should == '/' }
  end

  context "#url('www.aftonbladet.se')" do

    before { subject.url('www.aftonbladet.se') }

    its(:read_host)     { should == 'www.aftonbladet.se' }
    its(:read_port)     { should == 80 }
    its(:composed_path) { should == '/' }
  end

  context "#url('http://www.aftonbladet.se:92/customers')" do

    before { subject.url('http://www.aftonbladet.se:92/customers') }

    its(:read_host)          { should == 'www.aftonbladet.se' }
    its(:read_port)          { should == 92 }
    its(:composed_path)      { should == '/customers' }
  end

  context "Resto::Request::Base.new()
            .url('http://www.aftonbladet.se:92/customers)
            .query('q=adam')
            .params('longUrl' => 'http://betaworks.com', 'short' => 'htt')" do

    before do
      subject.url('http://www.aftonbladet.se:92/customers')
        .query('q=adam')
        .params('longUrl' => 'http://betaworks.com', 'short' => 'htt')
    end

    its(:read_host)     { should == 'www.aftonbladet.se' }
    its(:read_port)     { should == 92 }
    its(:composed_path) do
      should == '/customers?q=adam&longUrl=http%3A%2F%2Fbetaworks.com&short=htt'
    end
  end

  context "#port(40)
            .url('http://www.aftonbladet.se:92/customers)
            .query('q=adam')
            .path('contacts')" do

    before do
      subject.port(40)
        .url('http://www.aftonbladet.se:92/customers')
        .query('q=adam')
        .path('contacts')
    end

    its(:read_host)      { should == 'www.aftonbladet.se' }
    its(:read_port)      { should == 40 }
    its(:composed_path)  { should == '/contacts?q=adam' }
  end

  context "#url('http://www.aftonbladet.se:92/customers/?q=adam')" do

    before { subject.url('http://www.aftonbladet.se:92/customers/?q=adam') }

    its(:read_host)          { should == 'www.aftonbladet.se' }
    its(:read_port)          { should == 92 }
    its(:composed_path)      { should == '/customers/?q=adam' }
  end

  context "#url('http://www.aftonbladet.se:92/customers/?q=adam')
            .append_path(1)" do

    before do
      subject.url('http://www.aftonbladet.se:92/customers/?q=adam')
        .append_path(1)
    end

    its(:read_host)          { should == 'www.aftonbladet.se' }
    its(:read_port)          { should == 92 }
    its(:composed_path)      { should == '/customers/1?q=adam' }
  end

  context "#url('http://www.aftonbladet.se:92/customers/?q=adam')
            .query('q=take presendent')" do

     before do
       subject.url('http://www.aftonbladet.se:92/customers/?q=adam')
        .query("q=take presendent")
     end

     its(:read_host)          { should == 'www.aftonbladet.se' }
     its(:read_port)          { should == 92 }
     its(:composed_path)      { should == '/customers/?q=take presendent' }
   end

  context "#host('www.take_presedent.se')
            .url('http://www.aftonbladet.se:92/customers/?q=adam')
            .query('q=take presendent')" do

     before do
       subject.host('www.take-presedent.se')
        .url('http://www.aftonbladet.se:92/customers/?q=adam')
        .query('q=take presendent')
     end

     its(:read_host)          { should == 'www.take-presedent.se' }
     its(:read_port)          { should == 92 }
     its(:composed_path)      { should == '/customers/?q=take presendent' }
   end

  context "Resto::Request::Base.new.body('body text')" do
     before { subject.body('body text') }

     its(:read_body)  { should == 'body text' }
   end

   describe "#body" do

     context "when formatter is Resto::Format::Default" do
       before { subject.body('body text') }

       its(:read_body) { should == 'body text' }
     end

     context "when formatter is Resto::Format::Json" do
       before do
         subject.format(:json)
          .body( { :foo => 12425125, :bar => "some string" } )
        end

       its(:read_body) do
         should == Yajl::Encoder.encode({ :foo => 12425125,
                                          :bar => "some string" })
       end
     end
   end

   context "Resto::Request::Base.new(RequestKlass)" do
      subject do
        request_object = mock('request',
                              :head => "head",
                              :get => "get",
                              :post => "post",
                              :put => "put",
                              :delete => "delete")
        Resto::Request::Base.new(mock('request_klass', :new => request_object))
      end

      it "delegates method :head to Request instance" do
        subject.head.should == "head"
      end

      it "delegates method :get to Request instance" do
        subject.get.should == "get"
      end

      it "delegates method :post to Request instance" do
        subject.post.should == "post"
      end

      it "delegates method :put to Request instance" do
        subject.put.should == "put"
      end

      it "delegates method :delete to Request instance" do
        subject.delete.should == "delete"
      end
    end

end
