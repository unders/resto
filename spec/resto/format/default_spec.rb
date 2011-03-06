# encoding: utf-8

require 'spec_helper'
require 'resto/format'

describe "Resto::Format.get" do
  subject { Resto::Format.get }

  its(:extension)    { should == nil   }
  its(:accept)       { should == '*/*' }
  its(:content_type) { should == nil   }
  describe ".encode(text)" do
    it("returns text") do
      subject.encode('very important').should == 'very important'
    end
  end

  describe ".decode(text)" do
    it("returns text") do
      subject.encode('somehting important').should == 'somehting important'
    end
  end

end
