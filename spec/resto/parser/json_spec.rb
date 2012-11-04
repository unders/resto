require "resto/parser/json"

describe Resto::Parser::Json do
  subject(:parser) { Resto::Parser::Json } 

  describe '.decode(json)' do
    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    hash =  { 'foo' => 12425125, 'bar' => "some string" }

    it "returns a hash - decoded from the json string" do
      parser.decode(json).should == hash
    end 
  end

  describe ".encode(hash)" do
    hash  =  { 'foo' => 12425125, 'bar' => "some string" }

    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    it "returns a json string - encoded from the hash" do
      parser.encode(hash).should == json
    end
  end
end
