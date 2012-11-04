require "resto/parser/json"

describe Resto::Parser::Json do
  subject(:parser) { Resto::Parser::Json } 

  describe '.decode(json)' do
    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    hash =  { 'foo' => 12425125, 'bar' => "some string" }

    it "decodes a json string into a hash" do
      parser.decode(json).should == hash
    end 
  end

  describe ".encode(hash)" do
    hash  =  { 'foo' => 12425125, 'bar' => "some string" }

    json = "{\"foo\":12425125,\"bar\":\"some string\"}"

    it "encodes a hash into a json string" do
      parser.encode(hash).should == json
    end
  end
end
