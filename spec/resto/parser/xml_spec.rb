require 'resto/parser/xml'

describe Resto::Parser::Xml do
  subject(:parser) { Resto::Parser::Xml }

  describe ".decode(xml, xpath)" do
    context "when xml is nil or an empty string" do

      it "returns an array with one empty hash" do
        parser.decode(nil, '//xzone').should == [{}]  
        parser.decode("", '//xzone').should == [{}]  
        parser.decode("    ", '//xzone').should == [{}]  
      end
    end

    context "when xpath finds no match" do
      xml = 
        '<?xml version="1.0"?>
        <zone>
          <nx-ttl>900</nx-ttl>
        </zone>'

      it "returns an array with one empty hash" do
        parser.decode(xml, '//xzone').should == [{}]  
      end
    end

    context "when xpath finds one item" do
      xml = 
        '<?xml version="1.0"?>
        <zone>
          <default-ttl>600</default-ttl>
          <nx-ttl>900</nx-ttl>
          <slave-nameservers/>
        </zone>'

      hash = { 'default-ttl' => '600', 
               'nx-ttl' => '900', 
               'slave-nameservers' => nil }

      it "returns an array with one hash item containing the decoded xml" do
        parser.decode(xml, '//zone').should == [hash]  
      end
    end
    
    context "when xpath finds many items" do
      xml = 
        '<?xml version="1.0"?>
        <zones>
          <zone>
            <domain>example.com</domain>
            <ns1/>
          </zone>
          <zone>
            <default-ttl>700</default-ttl>
            <ns-type>pri_sec</ns-type>
          </zone>
        </zones>'

      array = [ { 'domain' => "example.com", "ns1" => nil },
                { 'default-ttl' => "700", "ns-type" => "pri_sec" }]

      it "returns an array of hashes containing the decoded xml" do
        parser.decode(xml, "//zone").should == array    
        parser.decode(xml, "//zones/zone").should == array    
      end 
    end
  end

  describe ".encode(hash)" do
    hash = { 
      :zone => {
        'ns1' => nil,
        'ns-type' => "pri_sec",
        'nx-ttl' => 900,
        }
      }

    xml_header = '<?xml version="1.0" encoding="UTF-8"?>'
    xml = 
      '<zone>
        <ns1></ns1>
        <ns-type>pri_sec</ns-type>
        <nx-ttl>900</nx-ttl>
      </zone>'.gsub("\n", "").gsub(/\s+/, "")

    it "returns an xml encoded string" do
      parser.encode(hash).should == xml_header + xml
    end
  end
end
