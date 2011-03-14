# encoding: utf-8

require 'spec_helper'
require 'resto/format'

describe "Resto::Format.get(:xml)" do
  subject { Resto::Format.get(:xml) }

  its(:extension)         { should == 'xml' }
  its(:accept)            { should == 'application/xml, */*' }
  its(:content_type)      { should == 'application/xml;charset=utf-8' }

  let(:hash) do
    {:zone =>
      { 'default-ttl' => 600,
        'domain' => "example.com",
        'ns1' => nil,
        'ns-type' => "pri_sec",
        'nx-ttl' => 900,
        'slave-nameservers' => nil
      }
    }
  end

  describe ".encode(hash)" do
    before { @result = subject.encode(hash) }

    it { @result.should =~ /<\?xml version=\"1.0\"\?>/ }
    it { @result.should =~ /<zone>.+<\/zone>\Z/m }
    it { @result.should =~ /<default-ttl>600<\/default-ttl>/ }
    it { @result.should =~ /<ns1\/>/ }
    it { @result.should =~ /<slave-nameservers\/>/ }
  end

  let(:xml) do
    '<?xml version="1.0"?><zone>
    <default-ttl>600</default-ttl>
    <domain>example.com</domain>
    <ns1/>
    <ns-type>pri_sec</ns-type>
    <nx-ttl>900</nx-ttl>
    <slave-nameservers/>
    </zone>'
  end

  let(:xml_collection) do
    '<?xml version="1.0"?>
    <zones>
      <zone>
        <default-ttl>600</default-ttl>
        <domain>example.com</domain>
        <ns1/>
        <ns-type>pri_sec</ns-type>
        <nx-ttl>900</nx-ttl>
        <slave-nameservers/>
      </zone>
      <zone>
        <default-ttl>700</default-ttl>
        <domain>example.com</domain>
        <ns1/>
        <ns-type>pri_sec</ns-type>
        <nx-ttl>800</nx-ttl>
        <slave-nameservers/>
      </zone>
      </zones>'
  end

  let(:attributes) do
    { 'default-ttl' => "600",
      'domain' => "example.com",
      'ns1' => "",
      'ns-type' => "pri_sec",
      'nx-ttl' => "900",
      'slave-nameservers' => ""
    }
  end

  let(:second_attributes) do
    { 'default-ttl' => "700",
      'domain' => "example.com",
      'ns1' => "",
      'ns-type' => "pri_sec",
      'nx-ttl' => "800",
      'slave-nameservers' => ""
    }
  end

  describe '.decode(xml, xpath)' do
    context 'when one item' do
      it { subject.decode(xml, :xpath => '//zone').should == attributes }
    end

    context 'when 0 items' do
      it { subject.decode(xml, :xpath => '//xx0').should == {} }
    end

    context 'when a collection of two items' do
      it do
        subject.decode(xml_collection, :xpath => '//zone').should ==
          [attributes, second_attributes]
      end
    end
  end

end
