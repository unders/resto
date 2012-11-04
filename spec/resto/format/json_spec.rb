describe Resto::Format::Json do
  subject(:formatter) { Resto::Format::Json }

  specify { formatter.accept.should == 'application/json, */*' }
  specify { formatter.content_type.should == 'application/json' }
  specify { formatter.extension.should == 'json' }

  describe ".decode(json)" do
    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    hash =  { 'foo' => 12425125, 'bar' => "some string" }

    it "decodes a json string into a hash" do
      formatter.decode(json).should == [hash]
    end
  end

  describe ".encode(hash)" do
    hash  =  { 'foo' => 12425125, 'bar' => "some string" }

    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    it "encodes a hash into a json string" do
      formatter.encode(hash).should == json
    end
  end
end
    

   
