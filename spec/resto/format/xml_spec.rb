describe Resto::Format::Xml do
  subject(:formatter) { Resto::Format::Xml }

  its(:accept) { should == 'application/xml, */*' }
  its(:content_type) { should == 'application/xml;charset=utf-8' }
  its(:extension) { should == 'xml' }

  describe ".decode(xml)" do
    before { Resto.xml_decode = ->(xml, xpath) { "#{xml}-#{xpath}" } }

    it "delegates to Resto.xml_decode[xml] to handle the decoding" do
      formatter.decode("decoded", xpath: "x").should == ["decoded-x"]
    end

    it "returns an array containing the decoded xml string" do
      formatter.decode("xml", xpath: "x").should == ["xml-x"]
    end
  end

  describe ".encode(hash)" do
    before { Resto.xml_encode = ->(hash) { hash } }

    it "raises NoMethodError unless argument respond to .to_hash" do
      expect { formatter.encode("string") }.to raise_error(NoMethodError)
    end

    it "delegates to Resto.xml_encode[hash] to handle the encoding" do
      formatter.encode({ key: "encoded" }).should == { key: "encoded" }
    end

    it "returns the return value from Resto.xml_encode[hash]" do
      formatter.encode({ key: "encoded" }).should == { key: "encoded" }
    end
  end
end
