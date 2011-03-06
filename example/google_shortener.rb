# encoding: utf-8
$LOAD_PATH << File.dirname(__FILE__) + "../../lib"
require File.expand_path(File.join(File.dirname(__FILE__), 'key_setup.rb'))
require 'resto'

# http://goo.gl/
# http://code.google.com/apis/urlshortener/v1/getting_started.html
class Goog
  include Resto

  property :id,       String
  property :kind,     String
  property :long_url, String, :remote_name => 'longUrl'
  property :status,   String
  # property :analytics Hash
  # property :analytics Analytic

  resto_request do
    format  :json
    host    'https://www.googleapis.com'
    path    '/urlshortener/v1/url'
    query   "key=#{GOOGLE_KEY}"
  end

  resto_response do
    format    :json
    translator :default
  end
end

# g = Goog.fetch(:shortUrl => "http://goo.gl/fbsSx") # the added 'x'
# att the end makes the request invalid
g = Goog.fetch(:shortUrl => "http://goo.gl/fbsS")
puts "id: #{g.id}\n" + "kind: #{g.kind}\n" +
     "long_url: #{g.long_url}\n" + "status: #{g.status}\n"
puts "valid: #{g.valid?}"
puts g.response
puts g.response.code
#puts g.response.message

g = Goog.post(:longUrl => 'http://svt.se/2.22620/1.2309372/om_signalspaning')
puts "valid?: #{g.valid?}"
puts g.response.body
puts g.response.read_body
puts g.id

# g = Goog.fetch(:shortUrl => g.id, :projection => 'FULL')
# g = Goog.fetch(:shortUrl => g.id, :projection => 'ANALYTICS_TOP_STRINGS')
g = Goog.fetch(:shortUrl => g.id, :projection => 'ANALYTICS_CLICKS')
puts g.response.body
