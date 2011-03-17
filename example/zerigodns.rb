# encoding: utf-8
#http://www.zerigo.com/docs/apis/dns/1.1
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.expand_path(File.join(File.dirname(__FILE__), 'key_setup.rb'))

require 'resto'
require 'pp'

class Zerigo
  include Resto

  resto_request do
    format :xml, :extension => true
    basic_auth(:username => USERNAME, :password => PASSWORD)
    host 'http://ns.zerigo.com/'
  end
end

# Zones are called Domains in our web interface.
class Zone < Zerigo

  resource_identifier :id
  property :id, Integer do
    validate_presence
  end
  property :default_ttl, Integer, :remote_name => 'default-ttl'
  property :domain, String
  property :ns1, String
  property :ns_type, String, :remote_name => 'ns-type'
  property :nx_ttl, Integer, :remote_name => 'nx-ttl'
  property :slave_nameservers, String, :remote_name => 'slave-nameservers'
  property :state, String

  # Since the remote api doesn't return the attributes (the response body is
  # empty), we have to copy the attributes back into the instance.
  def self.put(attributes)
    new_attributes = attributes.merge({})
    zone = super

    if zone.valid_response?
      zone.body(new_attributes)
    else
      zone
    end
  end

  resto_request do
    path 'api/1.1/zones'
    translator [:zone]
  end

  resto_response do
    format :xml#, :xpath => '//zone'
    translator :default
  end
end
# Nokogiri, libxml-ruby
# http://www.engineyard.com/blog/2010/getting-started-with-nokogiri/
# http://nokogiri.org/
# http://www.w3.org/TR/xpath/
# http://www.w3schools.com/xpath/xpath_syntax.asp
puts  "Zone.all"
zones = Zone.all(:per_page => 3, :page => 1)
pp zones.first.id
pp zones.first.attributes

puts  "Zone.get(1871829974)"
zone = Zone.get(1871829974)
pp zone.attributes

puts "zone.body(default_ttl => 650).put"
zone = zone.body(:default_ttl => 650).put
pp zone.attributes
puts "#valid: #{zone.valid?}"
puts zone.errors

attributes = {
  :default_ttl => 600,
  :domain => "e-very-long-example.com",
  :ns_type => 'pri_sec',
  :nx_ttl => 900,
}

zone = Zone.post(attributes)
pp zone.attributes
puts "#valid: #{zone.valid?}"
puts zone.errors


 xml =<<-XML
<zone>
  <nx-ttl nil="true"></nx-ttl>
  <default-ttl type="integer">900</default-ttl>
  <created-at type="datetime">2010-12-04T22:17:14Z</created-at>
  <follow-template>no</follow-template>
  <ns2 nil="true"></ns2>
  <updated-at type="datetime">2011-03-06T15:53:15Z</updated-at>
  <domain>readinglist.com</domain>
  <zone-template-id nil="true"></zone-template-id>
  <ns3 nil="true"></ns3>
  <hosts type="array"/>
  <notes nil="true"></notes>
  <tag-list></tag-list>
  <slave-nameservers></slave-nameservers>
  <state>active</state>
  <ns-type>pri_sec</ns-type>
  <ns-type>pri_sec</ns-type>
  <ns1 nil="true"></ns1>
  <customer-id type="integer">1712607333</customer-id>
  <hosts-count type="integer">0</hosts-count>
  <id type="integer">1871829974</id>
</zone>
XML

#doc = Nokogiri::XML(xml)
#path = doc.xpath('//zone')
#puts path.size
#path.each do |node|
#  puts "********************"
#  node.children.map do |child|
#    puts "#{child.name} : #{child.text}" if child.is_a?(Nokogiri::XML::Element)
#  end
#end

# http://woss.name/2011/03/06/using-tcpflow/
# tcpflow
# http://www.circlemud.org/~jelson/software/tcpflow/tcpflow.1.html
#require 'rubygems'
#require 'nokogiri'
#
#attribute_name = "follow-template"# <follow-template>no</follow-template>
#@builder = Nokogiri::XML::Builder.new do |xml|
#
#  xml.zone do
#    xml.nx_ttl(:nil => "true") { xml.text "" }
#    xml.default_ttl(:type => true) { xml.text 900 }
#    xml.send(attribute_name, :type => "Integer") { xml.text 'no' }
#    xml.send("created-at",  :type => "datetime") do
#      xml.text "2010-12-04T22:17:14Z"
#    end
#  end
#end
#
#puts @builder.doc



