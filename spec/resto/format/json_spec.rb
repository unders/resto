describe Resto::Format::Json do
  subject(:formatter) { Resto::Format::Json }

  its(:accept) { should == 'application/json, */*' }
  its(:content_type) { should == 'application/json' }
  its(:extension) { should == 'json' }

  describe ".decode(json)" do
    before { Resto.json_decode = ->(json) { json } }

    it "delegates to Resto.json_decode[json] to handle the decoding" do
      formatter.decode("decoded").should == ["decoded"]
    end

    it "returns an array containing the decoded json string" do
      formatter.decode("json").should == ["json"]
    end

    it "returns an array containing an empty hash when passed nil value" do
      formatter.decode(nil).should == [{}]
    end

    it "returns an array containing an empty hash when passed '' value" do
      formatter.decode('').should == [{}]
    end

    it "returns an array containing an empty hash when passed '   ' value" do
      formatter.decode('    ').should == [{}]
    end
  end

  describe ".encode(hash)" do
    before { Resto.json_encode = ->(hash) { hash } }

    it "raises NoMethodError unless argument respond to .to_hash" do
      expect { formatter.encode("string") }.to raise_error(NoMethodError)
    end

    it "delegates to Resto.json_encode[hash] to handle the encoding" do
      formatter.encode({ key: "encoded" }).should == { key: "encoded" }
    end

    it "returns the return value from Resto.json_encode[hash]" do
      formatter.encode({ key: "encoded" }).should == { key: "encoded" }
    end
  end
end
    
