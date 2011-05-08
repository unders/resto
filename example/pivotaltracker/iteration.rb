# encoding: utf-8
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '../../../', 'lib'))
require 'resto'

class Iteration < PivotalTracker
  resource_identifier :id
  property :id, Integer do
    validate_presence
  end
  property :number, Integer
  property :start, Time
  property :finish, String

  resto_request do
    translator [:iteration]
    path "services/v3/projects/:project_id/:add_to_path"
  end

  def self.done(project_id, params = {})
    all(project_id, params, 'iterations/done')
  end

  def self.current(project_id)
    all(project_id, {}, 'iterations/current')
  end

  def self.backlog(project_id, params = {})
    all(project_id, params, 'iterations/backlog')
  end

  def self.all(project_id, params = {}, add_to_path = 'iterations')
    super(params, { :project_id => project_id, :add_to_path => add_to_path })
  end
end

