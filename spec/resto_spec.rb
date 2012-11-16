require 'json'

describe Resto do

  describe ".json_decode[json]" do
    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    hash =  { 'foo' => 12425125, 'bar' => "some string" }

    it "returns a hash - decoded from the json string" do
      Resto.json_decode[json].should == hash
    end
  end

  describe ".json_encode[hash]" do
    hash  =  { 'foo' => 12425125, 'bar' => "some string" }

    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    it "returns a json string - encoded from the hash" do
      Resto.json_encode[hash].should == json
    end
  end
end
