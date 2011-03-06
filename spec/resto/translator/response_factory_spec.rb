# encoding: utf-8

require 'spec_helper'

class A
  include Resto

  property :title, String
  property :body, String
  property :number, Integer, :remote_name => 'very_long_number_name'
end

class Translator
  def call(klass, hash)
    klass.new(hash[:article])
  end
end

describe Resto::Translator::ResponseFactory do

  context ".create([:root, :article])" do
    describe "#call(klass, hash)" do

      let(:factory) do
        Resto::Translator::ResponseFactory.create([:root, :article])
      end

      hash = {  :root => {
                  :article => {
                    :body => 'This is a very good article',
                    :title => 'Very interesting subject',
                    'very_long_number_name' => '500' } } }

      subject { factory.call(A, hash) }

      it { should be_instance_of(A) }

      its(:attributes) do
        should == { :body => 'This is a very good article',
                    :title => 'Very interesting subject',
                    :number => 500 }
      end
      its(:number) { should == 500 }
      its(:title)  { should ==  'Very interesting subject' }
      its(:body)   { should ==  'This is a very good article' }
    end
  end

  context ".create(Translator)" do
    describe "#call(klass, hash)" do

      let(:factory) { Resto::Translator::ResponseFactory.create(Translator) }

      hash = {  :article => {
                  :body => 'This is a very good articel',
                  :title => 'Very interesting subject' } }

      subject { factory.call(A, hash) }

      it { should be_instance_of(A) }
      its(:attributes) do
        should == { :body => 'This is a very good articel',
                    :title => 'Very interesting subject' }
      end
    end
  end

  context ".create(:default)" do
    describe "#call(klass, hash)" do

      let(:factory) { Resto::Translator::ResponseFactory.create(:default) }

      hash = {  :body => 'This is a very good articel',
                :title => 'Very interesting subject' }

      subject { factory.call(A, hash) }

      it { should be_instance_of(A) }
      its(:attributes) do
        should == { :body => 'This is a very good articel',
                    :title => 'Very interesting subject' }
      end
    end
  end

  describe ".create(:invalid_symbol)" do
    it "raises ArgumentError when invalid argument" do
      lambda do
        Resto::Translator::ResponseFactory.create(:invalid_symbol)
      end.should raise_error(ArgumentError)
    end
  end
end
