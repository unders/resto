# encoding: utf-8
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__),
                                         '../../../', 'lib'))
require 'resto'

class PivotalTracker
  include Resto

  resto_request do
    headers "X-TrackerToken" => API_TOKEN
    format :xml
    host 'http://www.pivotaltracker.com/'
  end

  resto_response do
    format :xml
    translator :default
  end
end
