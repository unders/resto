# encoding: utf-8

require 'spec_helper'
require 'resto/format'

describe "Resto::Format.get(:xml)" do
  subject { Resto::Format.get(:xml) }

  its(:extension)         { should == 'xml' }
  its(:accept)            { should == 'application/xml, */*' }
  its(:content_type)      { should == 'application/xml;charset=utf-8' }

end
