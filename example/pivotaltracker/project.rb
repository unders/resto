# encoding: utf-8
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__),
                                         '../../../', 'lib'))
require 'resto'

class Project < PivotalTracker

  resource_identifier :id
  property :id, Integer do
    validate_presence
  end
  property :name, String
  property :account, String
  property :week_start_day, String
  property :point_scale, String
  property :week_start_day, String
  property :velocity_scheme, String
  property :iteration_length, Integer
  property :initial_velocity, Integer
  property :current_velocity, Integer
  property :last_activity_at, String #DateTime
  property :use_https, String #Boolean

  has_many  :stories,
            :class_name => :story,
            #:relation => { :project_id => :id }
            :params => { :project_id => :id, :limit => 4 }

  resto_request do
    path 'services/v3/projects'
    translator [:project]
  end
end

