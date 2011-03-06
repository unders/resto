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

  property :created_at, String #2010-12-04T22:10:57Z
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
    host    'https://test.dnsimple.com/'
    path    '/domains'
    #ca_file File.join('/Users/unders/CA', "server.crt")
    cert  OpenSSL::X509::Certificate.new(File.read("/Users/unders/CA/server.crt"))
    read_timeout 5
    #http.verify_depth = 5
    verify_none
    #verify_callback(
    #  Proc.new do |preverify_ok, ssl_context|
    #
    #    puts "inne i callback"
    #     if preverify_ok != true || ssl_context.error != 0
    #       puts ssl_context.inspect
    #       err_msg = "SSL Verification failed -- Preverify: #{preverify_ok}, Error: #{ssl_context.error_string} (#{ssl_context.error})"
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

