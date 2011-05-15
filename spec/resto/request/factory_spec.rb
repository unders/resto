# encoding: utf-8

require 'spec_helper'
require 'resto/request/base'

describe Resto::Request::Factory do

  let(:factory) { Resto::Request::Factory }
  let(:base) { Resto::Request::Base.new }

  subject do
    factory.new(base.
                  host('sr.se').
                  port(8080).
                  headers('content-type' => 'text/html').
                  body('Anders').
                  path('/dashboard'))
  end

  describe "#head" do
    before do
      stub_request(:head, "sr.se:8080/dashboard").
        with(:headers => headers("content-type" => "text/html")).
        to_return(:status => 200)
    end

    it { subject.head.code.should == "200" }
  end

  describe "#get" do
    before do
      stub_request(:get, "sr.se:8080/dashboard").
        with(:headers => headers("content-type" => "text/html")).
        to_return(:status => 200)
    end

    it { subject.get.code.should == "200" }
  end

  describe "#post" do
    before do
      stub_request(:post, "sr.se:8080/dashboard").
        with(:headers => headers("content-type" => "text/html"),
             :body => 'Anders').
        to_return(:status => 200)
    end

    it { subject.post.code.should == "200" }
  end

  describe "#put" do
    before do
      stub_request(:put, "sr.se:8080/dashboard").
        with(:headers => headers("content-type" => "text/html"),
             :body => 'Anders').
        to_return(:status => 200)
    end

    it { subject.put.code.should == "200" }
  end

  describe "#delete" do
    before do
      stub_request(:delete, "sr.se:8080/dashboard").
        with(:headers => headers("content-type" => "text/html")).
        to_return(:status => 200)
    end

    it { subject.delete.code.should == "200" }

  end

  context "other settings" do
    subject do
      factory.new(Resto::Request::Base.new.
                  host('sr.se').
                  path('/friends_timeline').
                  body('Anders').
                  headers('content-type' => 'application/xml').
                  basic_auth(:username => 'developer', :password => 'secret'))
    end

    describe "#head" do
      before do
        stub_request(:head, "developer:secret@sr.se/friends_timeline").
          with(:headers => headers("content-type" => "application/xml")).
          to_return(:status => 200)
      end

      it { subject.head.code.should == "200" }
    end

    describe "#get" do
      before do
        stub_request(:get, "developer:secret@sr.se/friends_timeline").
          with(:headers => headers("content-type" => "application/xml")).
          to_return(:status => 200)
      end

      it { subject.get.code.should == "200" }
    end

    describe "#post" do
      before do
        stub_request(:post, "developer:secret@sr.se/friends_timeline").
          with(:headers => headers("content-type" => "application/xml"),
               :body => 'Anders').
          to_return(:status => 200)
      end

      it { subject.post.code.should == "200" }
    end
  end
end
