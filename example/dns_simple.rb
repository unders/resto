# encoding: utf-8
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.expand_path(File.join(File.dirname(__FILE__), 'key_setup.rb'))

require 'resto'
require 'pp'

class DomainTranslator
  def call(klass, hash)
    klass.new(hash['data']['translations'][0])
  end
end

class Domain
  include Resto

  property :created_at, Time #2010-12-04T22:10:57Z
  property :expires_at, String
  property :id, String
  property :name, String
  property :name_server_status, String
  property :registrant_id, String
  property :registration_status, String
  property :updated_at, String #2010-12-04T22:10:57Z
  property :user_id, String
  property :uses_external_name_servers, String

  resto_request do
    format  :json, :extension => :true
    basic_auth(:username => USERNAME,
               :password => PASSWORD)
    #host    'https://dnsimple.com/'
    host    'https://dnsimple.com/'
    path    '/domains'
    #ca_file File.join('/Users/unders/CA', "server.crt")
  #cert OpenSSL::X509::Certificate.new(File.read("/Users/unders/CA/server.crt"))
    #read_timeout 5
    #http.verify_depth = 5
    verify_none
    #verify_callback(
    #  Proc.new do |preverify_ok, ssl_context|
    #
    #    puts "inne i callback"
    #     if preverify_ok != true || ssl_context.error != 0
    #       puts ssl_context.inspect
    #       err_msg = "SSL Verification failed --
    # Preverify: #{preverify_ok}, Error: #{ssl_context.error_string}
    # (#{ssl_context.error})"
    #       raise OpenSSL::SSL::SSLError.new(err_msg)
    #     true
    #     end
    #     true
    #   end
    #   )
    # body_translator [:domain]
  end

  resto_response do
    format    :json
    translator [:domain]
  end
end

collection =  Domain.all

puts collection.length

domain = collection.first
puts domain.attributes.inspect

# the output is when the file is executed in time_zone=ETC at
# date 2011-05-08 (+02:00)
puts "remote string :created_at=>'2011-02-04T14:07:29Z'"
puts domain.created_at # 2011-02-04 14:07:29 UTC
puts domain.created_at.iso8601 # 2011-02-04T14:07:29Z
puts domain.created_at.localtime # 2011-02-04 15:07:29 +0100
puts domain.created_at.utc #2011-02-04 14:07:29 UTC

# the output is when the file is executed in time_zone=ETC at
# date 2011-05-08 (+02:00)
puts "remote string :created_at=>'2011-05-08T13:03:13Z'"
puts domain.created_at # 2011-05-08 13:03:13 UTC
puts domain.created_at.iso8601 # 2011-05-08T13:03:13Z
puts domain.created_at.localtime # 2011-05-08 15:03:13 +0200
#puts domain.created_at.utc # 2011-05-08 13:03:13 UTC

require 'date'
puts "\n ** datetime **"
if RUBY_VERSION.to_i < 1.9
  puts domain.created_at.send(:to_datetime) # 2011-05-08T15:03:13+02:00
else
  puts domain.created_at.to_datetime # 2011-05-08T15:03:13+02:00
  puts domain.created_at.to_datetime.iso8601 # 2011-05-08T15:03:13+02:00
end

__END__


#collection.each_with_index do |domain, index|
#  puts  domain.id
#  puts  domain.name
#  puts  domain.valid?
#  puts  domain.registrant_id
#  pp    domain.response.read_body[index]
#  pp    domain.response.response.code
#  pp    domain.response.response.body
#end

# I get an error at:
# /Users/unders/.rvm/rubies/ruby-1.9.2-p0/lib/ruby/1.9.1/net/protocol.rb:146:in
# `rescue in rbuf_fill': Timeout::Error (Timeout::Error)

dns_parrot = Domain.post(:domain => { :name => 'dnsddd-parrot.se'})

pp    dns_parrot
pp    dns_parrot.response.read_body
pp    dns_parrot.response.response.code
pp    dns_parrot.response.response.body


puts  dns_parrot.name
puts  dns_parrot.valid?

