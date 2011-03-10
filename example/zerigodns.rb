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
  resto_request do
    path 'api/1.1/zones'
  end
end

# Nokogiri, libxml-ruby
# http://www.engineyard.com/blog/2010/getting-started-with-nokogiri/
# http://nokogiri.org/
# http://www.w3.org/TR/xpath/
# http://www.w3schools.com/xpath/xpath_syntax.asp
#Zone.all(:per_page => 3, :page => 1)
#Zone.get(1871829974)

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
      <ns1 nil="true"></ns1>
      <customer-id type="integer">1712607333</customer-id>
      <hosts-count type="integer">0</hosts-count>
      <id type="integer">1871829974</id>
    </zone>

# http://woss.name/2011/03/06/using-tcpflow/
# tcpflow
require 'rubygems'
require 'nokogiri'

attribute_name = "follow-template"# <follow-template>no</follow-template>
@builder = Nokogiri::XML::Builder.new do |xml|

  xml.zone {
    xml.nx_ttl(:nil => "true")
    xml.default_ttl(:type => true) { xml.text 900 }
    xml.send(attribute_name, :type => "Ingeter") { xml.text 'no' }
  }
end

puts @builder.doc

