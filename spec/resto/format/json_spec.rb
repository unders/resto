describe Resto::Format::Json do
  subject(:formatter) { Resto::Format::Json }

  its(:accept) { should == 'application/json, */*' }
  its(:content_type) { should == 'application/json' }
  its(:extension) { should == 'json' }

  describe ".decode(json)" do
    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    hash =  { 'foo' => 12425125, 'bar' => "some string" }

    it "returns a hash - decoded from the json string" do
      formatter.decode(json).should == [hash]
    end
  end

  describe ".encode(hash)" do
    hash  =  { 'foo' => 12425125, 'bar' => "some string" }

    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    it "returns a json string - encoded from the hash" do
      formatter.encode(hash).should == json
    end
  end
end
    

   
