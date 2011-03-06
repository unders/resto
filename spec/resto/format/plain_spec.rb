# encoding: utf-8

require 'spec_helper'
require 'resto/format'

describe "Resto::Format.get(:plain)" do
  subject { Resto::Format.get(:plain) }

  its(:extension)    { should == nil }
  its(:accept)       { should == 'text/plain, */*' }
  its(:content_type) { should == 'text/plain' }

  context ".encode(text)" do
    it("returns text") { subject.encode('important').should == 'important' }
  end

  context ".decode(text)" do
    it("returns text") { subject.encode('important').should == 'important' }
  end

end
