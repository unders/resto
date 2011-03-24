# encoding: utf-8
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__),
                                         '../../../', 'lib'))
require 'resto'

class Story < PivotalTracker; end

class << Story
  def all(params, dummy={})
    super(params, :project_id => params.delete(:project_id))
  end

  def post(attributes)
    super(attributes, :project_id => attributes.delete(:project_id))
  end
end

class Story
  resource_identifier :id
  property :id, Integer do
    validate_presence
  end
  property :project_id, Integer
  property :story_type, String
  property :url, String
  property :estimate, Integer
  property :current_state, String
  property :description, String
  property :name, String
  property :requested_by, String
  property :owned_by, String
  property :created_at, String
  property :accepted_at, String
  property :labels, String

  belongs_to :project

  resto_request do
    translator [:story]
    path "services/v3/projects/:project_id/stories"
  end

  def request_path_options
    { :project_id => project_id }
  end

end

