# encoding: utf-8
$LOAD_PATH << File.dirname(__FILE__) + "../../lib"
require File.expand_path(File.join(File.dirname(__FILE__), 'key_setup.rb'))

require 'resto'

# http://code.google.com/apis/language/translate/v2/using_rest.html
# https://github.com/jimmycuadra/to_lang <- Google translate

class GoogTranslator
  def call(klass, hash)
    klass.new(hash['data']['translations'][0])
  end
end

class Goog
  include Resto

  property :translated_text, String, :remote_name => 'translatedText'

  resto_request do
    format  :json
    host    'https://www.googleapis.com'
    path    '/language/translate/v2'
    query   "key=#{GOOGLE_KEY}"
  end

  resto_response do
    format    :json
    # translator GoogTranslator
    # translator lambda { |klass, hash| klass.new(hash['data']['translations'][0]) }
    translator lambda { |_, hash| Goog.new(hash['data']['translations'][0]) }
  end
end

g = Goog.fetch(:source => "sv", :target => 'en', :q => "Hej världen!")
puts g.translated_text
