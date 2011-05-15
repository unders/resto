# encoding: utf-8

require 'spec_helper'

describe Resto do
  class_context(%Q{
    class Subscription
      include Resto

      resource_identifier :id
      property :id, Integer
      property :product_id, Integer
      property :customer_id, Integer
      property :cancellation_message, String
      property :state, String

      resto_request do
        format :json, :extension => true
        basic_auth(:username => 'EyphE_t',
                   :password => 'x')

        host 'https://dns-parrot.chargify.com/'
        path '/subscriptions'
        translator [:subscription]
      end

      resto_response do
        format :json
        translator [:subscription]
      end
    end}) do

    let(:attributes) do
      { :id => 415520,
        :product_id => 25450,
        :customer_id => 416942,
        :cancellation_message => 'The reason',
        :state =>"canceled"
      }
    end

    let(:body) do
      { :subscription => attributes.merge({}).reject { |k, _| k == :id } }
    end

    let(:response) do
      { :subscription => attributes }
    end

    describe ".all" do
      before do
        stub_request(:get,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions.json").
            with(:headers => headers('accept' => 'application/json, */*',
                                    'content-type' => 'application/json')).
            to_return(:status => 200, :body => [response].to_json)
      end

      subject { Subscription.all.first }

      it                          { should be_instance_of(Subscription) }
      its(:id)                    { should == 415520 }
      its(:product_id)            { should == 25450 }
      its(:customer_id)           { should == 416942 }
      its(:cancellation_message)  { should == 'The reason' }
      its(:state)                 { should == 'canceled' }
      it                          { should be_valid }
    end

    describe ".get(id)" do
      before do
        stub_request(:get,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions/415520.json").
          with(:headers => headers('accept' => 'application/json, */*',
                                    'content-type' => 'application/json')).
          to_return(:status => 200, :body => response.to_json)
      end

      subject { Subscription.get(415520) }

      it                          { should be_instance_of(Subscription) }
      its(:id)                    { should == 415520 }
      its(:product_id)            { should == 25450 }
      its(:customer_id)           { should == 416942 }
      its(:cancellation_message)  { should == 'The reason' }
      its(:state)                 { should == 'canceled' }
      it                          { should be_valid }
    end

    describe "#get" do
      before do
        stub_request(:get,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions/415520.json").
          with(:headers => headers('accept' => 'application/json, */*',
                                   'content-type' => 'application/json')).
          to_return(:status => 200, :body => response.to_json)
      end

      subject { Subscription.new(attributes).get }

      it { should be_instance_of(Subscription) }
      its(:id)                    { should == 415520 }
      its(:product_id)            { should == 25450 }
      its(:customer_id)           { should == 416942 }
      its(:cancellation_message)  { should == 'The reason' }
      its(:state)                 { should == 'canceled' }
      it                          { should be_valid }
    end

    describe "#reload" do
      before do
        stub_request(:get,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions/415520.json").
          with(:headers => headers('accept' => 'application/json, */*',
                                    'content-type' => 'application/json')).
           to_return(:status => 200, :body => response.to_json)
      end

      subject { Subscription.new(attributes).reload }

      it { should be_instance_of(Subscription) }
      its(:id)                    { should == 415520 }
      its(:product_id)            { should == 25450 }
      its(:customer_id)           { should == 416942 }
      its(:cancellation_message)  { should == 'The reason' }
      its(:state)                 { should == 'canceled' }
      it                          { should be_valid }
    end

    describe ".post(attributes)" do
      before do
        stub_request(:post,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions.json").
          with(:headers => headers('accept' => 'application/json, */*',
                                   'content-type' => 'application/json'),
               :body => body.to_json).
          to_return(:status => 201, :body => response.to_json)
      end

      subject { Subscription.post(attributes) }

      it                          { should be_instance_of(Subscription) }
      its(:id)                    { should == 415520 }
      its(:product_id)            { should == 25450 }
      its(:customer_id)           { should == 416942 }
      its(:cancellation_message)  { should == 'The reason' }
      its(:state)                 { should == 'canceled' }
      it                          { should be_valid }
    end

    describe ".put(attributes)" do
      before do
        stub_request(:put,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions/415520.json").
           with(:headers => headers('accept' => 'application/json, */*',
                                   'content-type' => 'application/json'),
               :body => body.to_json).
          to_return(:status => 200, :body => response.to_json)
      end

      subject { Subscription.put(attributes) }

      it                          { should be_instance_of(Subscription) }
      its(:id)                    { should == 415520 }
      its(:product_id)            { should == 25450 }
      its(:customer_id)           { should == 416942 }
      its(:cancellation_message)  { should == 'The reason' }
      its(:state)                 { should == 'canceled' }
      it                          { should be_valid }
    end

    describe "#put" do
      before do
        stub_request(:put,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions/415520.json").
          with(:headers => headers('accept' => 'application/json, */*',
                                   'content-type' => 'application/json'),
               :body => body.to_json).
          to_return(:status => 200, :body => response.to_json)
      end

      subject { Subscription.new(attributes).put }

      it                          { should be_instance_of(Subscription) }
      its(:id)                    { should == 415520 }
      its(:product_id)            { should == 25450 }
      its(:customer_id)           { should == 416942 }
      its(:cancellation_message)  { should == 'The reason' }
      its(:state)                 { should == 'canceled' }
      it                          { should be_valid }
    end

    describe ".delete(id)" do
      before do
        stub_request(:delete,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions/415520.json").
          with(:headers => headers('accept' => 'application/json, */*',
                                    'content-type' => 'application/json')).
          to_return(:status => 200)
      end

      subject { Subscription.delete(415520) }

      it                          { should be_instance_of(Subscription) }
      it                          { should be_valid }
    end

    describe "#delete" do
      before do
        stub_request(:delete,
          "https://EyphE_t:x@dns-parrot.chargify.com/subscriptions/415520.json").
          with(:headers => headers('accept' => 'application/json, */*',
                                   'content-type' => 'application/json')).
          to_return(:status => 200)
      end

      subject { Subscription.new(attributes).delete }

      it             { should be_instance_of(Subscription) }
      it             { should be_valid }
      its(:id)       { should be_nil }
    end

    describe "#update_attributes(attributes)" do
      subject do
        Subscription.new(attributes).update_attributes(:state => "updated")
      end

      its(:state) { should == "updated" }
    end

    describe "#body(attributes)" do
      subject do
        Subscription.new(attributes).body(:state => "updated")
      end

      its(:state) { should == "updated" }
    end

  end

  class_context(%Q{
    class RestUser
      include Resto

      property :id, Integer
      property :title, String
      property :body, String, :remote_name => 'a_bad_body_name' do
        validate_presence .if { |user| user.title.to_s.size < 3 } .
          message 'must be present'
      end

      resto_request do
        host    'http://api.bit.ly'
        path    '/v3/users'
        format  :json
      end

      resto_response do
        format    :json
        translator [:root, :user]
      end
    end}) do

    describe ".new" do
      it { RestUser.new({:name => 'Anders'}).should be_instance_of(RestUser) }
    end

    describe ".get(id)" do
      let(:request) do
        stub_request(:get, "http://api.bit.ly/v3/users/200").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json'))
      end

      subject { RestUser.get(200) }

      context "response with valid body attribute" do
        before do
          body = {:root => { :user => {'a_bad_body_name' => 'Content',
                                       'title' => 'Read this',
                                       'id' => '100' } } }
            request.to_return(:status => 200, :body => body.to_json)
        end

        it          { should be_instance_of(RestUser) }
        its(:id)    { should ==  100 }
        its(:title) { should ==  'Read this' }
        its(:body)  { should ==  'Content' }
        it          { should be_valid }
      end

      context "response with invalid body attribute" do
        before do
          request.to_return(:status => 200, :body => {}.to_json)
          subject.valid?
        end

        it           { should be_instance_of(RestUser ) }
        its(:id)     { should == nil }
        its(:title)  { should == nil }
        its(:body)   { should == nil }
        it           { should_not be_valid }
        its(:errors) { should == [":body must be present"] }
      end
    end
  end

  class_context(%{
    class RestArticle
      include Resto

      resto_request do
        host    'http://api.bit.ly'
        path    '/v3/articles'
        format  :json
      end

      resto_response do
        format    :json
      end
    end}) do

    describe ".all" do
      before do
        stub_request(:get, "http://api.bit.ly/v3/articles").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticle.all.code.should == "200" }
    end

    describe ".all('tag' => 'resto')" do
      before do
        stub_request(:get, "http://api.bit.ly/v3/articles?tag=resto").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticle.all('tag' => 'resto').code.should == "200" }
    end

    describe ".head" do
      before do
        stub_request(:head, "http://api.bit.ly/v3/articles").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticle.head.code.should == "200" }
    end

    describe ".get(200)" do
      before do
        stub_request(:get, "http://api.bit.ly/v3/articles/200").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticle.get(200).code.should == "200" }
    end

    describe ".post(:author => 'Anders')" do
      before do
        stub_request(:post, "http://api.bit.ly/v3/articles").
          with(:body => { "author" => "Anders"}.to_json,
               :headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticle.post(:author => 'Anders').code.should == "200" }
    end

    describe ".put(:author => 'Anders')" do
      before do
        stub_request(:put, "http://api.bit.ly/v3/articles").
          with(:body => { "author"=> "Anders"}.to_json,
               :headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticle.put(:author => 'Anders').code.should == "200" }
    end

    describe ".delete(400)" do
      before do
        stub_request(:delete, "http://api.bit.ly/v3/articles/400").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticle.delete(400).code.should == "200" }
    end
  end

  class_context(%Q{
    class RestArticleWithExtension
      include Resto

      resto_request do
        host    'http://api.bit.ly'
        path    '/v3/articles'
        format  :json, :extension => :true
      end

    end}) do

    describe ".all" do
      before do
        stub_request(:get, "http://api.bit.ly/v3/articles.json").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticleWithExtension.all.code.should == "200" }
    end

    describe ".all('tag' => 'resto')" do
      before do
        stub_request(:get, "http://api.bit.ly/v3/articles.json?tag=resto").
           with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticleWithExtension.all('tag' => 'resto').code.should == "200" }
    end

    describe ".head" do
      before do
        stub_request(:head, "http://api.bit.ly/v3/articles.json").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticleWithExtension.head.code.should == "200" }
    end

    describe ".get(200)" do
      before do
        stub_request(:get, "http://api.bit.ly/v3/articles/200.json").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticleWithExtension.get(200).code.should == "200" }
    end

    describe ".post(:author => 'Anders')" do
      before do
        stub_request(:post, "http://api.bit.ly/v3/articles.json").
          with(:body => { "author" => "As" }.to_json,
               :headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
           to_return(:status => 200)
      end

      it { RestArticleWithExtension.post(:author => 'As').code.should == "200" }
    end

    describe ".put(:author => 'Anders')" do
      before do
        stub_request(:put, "http://api.bit.ly/v3/articles.json").
          with(:body => { "author" => "An" }.to_json,
               :headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticleWithExtension.put(:author => 'An').code.should == "200" }
    end

    describe ".delete(400)" do
      before do
        stub_request(:delete, "http://api.bit.ly/v3/articles/400.json").
          with(:headers => headers('accept'=>'application/json, */*',
                                   'content-type'=>'application/json')).
          to_return(:status => 200)
      end

      it { RestArticleWithExtension.delete(400).code.should == "200" }
    end
  end

  class_context(%Q{
    class Bitly
      include Resto

      resto_request do
        headers "content-type" => "text/html"
        host    'http://bit.ly'
        path    '/v3'
        query   "format=json"
        params  "longUrl" => "ll"
      end

    end}) do

    describe ".all()" do
      before do
        stub_request(:get, "http://bit.ly/v3?format=json&longUrl=ll").
          with(:headers => headers("content-type" => "text/html")).
          to_return(:status => 200)
      end

      it { Bitly.all.code.should == "200" }
    end

    describe ".all('shortUrl' => short)" do
      before do
        stub_request(:get, "http://bit.ly/v3?format=json&shortUrl=short").
          with(:headers => headers("content-type" => "text/html")).
          to_return(:status => 200)
      end

      it { Bitly.all('shortUrl' => 'short').code.should == "200" }
    end
  end

end
