# encoding: utf-8
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.expand_path(File.join(File.dirname(__FILE__), 'key_setup.rb'))

require 'resto'
require 'pp'

# http://docs.chargify.com/api-authentication
# http://docs.chargify.com/api-introduction
# http://docs.chargify.com/api-resources
class Chargify
  include Resto

  resto_request do
    format :json, :extension => true
    basic_auth(:username => API_KEY, :password => API_PASSWORD)
    host 'https://dns-parrot.chargify.com/'
  end

  resto_response do
    format :json
  end
end

# http://docs.chargify.com/api-products
class Product < Chargify
  resource_identifier :id
  property :id, Integer
  property :price_in_cents, Integer
  property :interval, Integer
  property :created_at, Time
  #property :created_at, String
  property :name, String

  resto_request do
    path 'products'
    translator [:product]
  end

  resto_response do
    translator [:product]
  end

end


#puts "products ************************"
products = Product.all
puts products.size
product = products.first
puts product.attributes

# the output is when the file is executed in time_zone=ETC at
# date 2011-05-08 (+02:00)
puts "remote string created_at=>'2011-02-07T15:03:42-05:00'"
puts product.created_at # 2011-02-07 21:03:42 +0100
puts product.created_at.iso8601 # 2011-02-07T21:03:42+01:00
puts product.created_at.localtime # 2011-02-07 21:03:42 +0100
#puts product.created_at.utc # 2011-02-07 20:03:42 UTC

require 'date'
puts "\n ** datetime **"
puts product.created_at.to_datetime # 2011-02-07T21:03:42+01:00
puts product.created_at.to_datetime.iso8601 # 2011-02-07T21:03:42+01:00

#puts "product.get(#{product.id}) ***************"
#product = Product.get(product.id)
#puts product.attributes

#puts "\n\n\n"

class Customer < Chargify

  # The id is the unique identifier for this customer within Chargify
  resource_identifier :id
  property :id,           Integer #{ validate_presence }
  property :first_name,   String  #{ validate_presence }
  property :last_name,    String  #{ validate_presence }
  property :email,        String  #{ validate_presence }
  property :organization, String
  property :created_at,   String
  property :updated_at,   String

  resto_request do
    path 'customers'
    translator [:customer]
  end

  resto_response do
    translator [:customer]
  end
end

body = {:first_name =>"Anders ska bort",
        :last_name => "Dum användare",
        :email => "anders.tornqvist@elabs.se" }

#puts "Customer.post(body)"
#customer = Customer.post(body)
#puts customer.attributes
#puts "\n"

#Customer deletion is not currently supported
#(you will receive a 403 Forbidden response
#puts "Customer.delete(customer.id)"
#removed =  Customer.delete(customer.id)
#puts removed.inspect
#puts removed.code
#puts removed.body


#puts "customers **************"
#customers = Customer.all
#puts customers.size
#customers.each { |customer| puts customer.attributes; puts "\n" }
#customer  = customers.first
##
#puts "Customer.get(#{customer.id}) *************"
#customer = Customer.get(customer.id)
#puts customer.attributes

#puts "\n\n"


# http://docs.chargify.com/api-subscriptions
# curl -u <api_key>:x -H Accept:application/json -H
# Content-Type:application/json https://acme.chargify.com/subscriptions.json
class Subscription < Chargify

  resource_identifier :id
  property :id, Integer
  property :product_id, Integer
  property :customer_id, Integer
  property :cancellation_message, String
  property :state, String

  resto_request do
    path '/subscriptions'
    translator [:subscription]
  end

  resto_response do
    translator [:subscription]
  end

end

attributes = {
  :product_id => 25450, # product = { id: 25450, name: 'dns' }
  :customer_id => 423360, # customer = { id:  416942, email: joe@example.com }
}

puts "subscriptions *************** \n"
subscriptions = Subscription.all
puts subscriptions.size
#puts subscriptions.first.response.body

subscriptions[1].tap {|s| puts "id: #{s.object_id}" }.get
  .tap { |s| puts "id: #{s.object_id}" }.reload
  .tap { |s| puts "id: #{s.object_id}, state: #{s.cancellation_message}" }
  .body(:cancellation_message => 'just a test').put
  .tap { |s| puts "id: #{s.object_id}, state: #{s.cancellation_message}" }
  .update_attributes(:cancellation_message => 'updated again').put
  .tap { |s| puts "id: #{s.object_id}, state: #{s.cancellation_message}" }



#subscription = Subscription.post attributes
#puts subscription.attributes
#subscription = subscriptions.each do |s|
#  puts s.attributes
#end

#subscription = Subscription.delete(415520)
#puts subscription.response.response
#puts subscription.attributes
