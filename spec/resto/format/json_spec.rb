# encoding: utf-8

require 'spec_helper'
require 'resto/format'
require 'yajl'

describe "Resto::Format.get(:json)" do
  subject { Resto::Format.get(:json) }

  its(:accept)         { should == 'application/json, */*' }
  its(:content_type)   { should == 'application/json' }

  describe '.decode(json)' do
    json = Yajl::Encoder.encode( { :foo => 12425125, :bar => "some string" })
    expected = { 'foo' => 12425125, 'bar' => "some string" }

    it { subject.decode(json).should == expected }
  end

  describe ".encode(hash)" do
    before { @result = subject.encode({ :bar => "some string",
                                        :foo => 12425125}) }

    it { @result.should =~ /bar\":\"some string/ }
    it { @result.should =~ /foo\":12425125/      }
  end

  its(:extension) { should == 'json' }
end
