# encoding: utf-8
#
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.expand_path(File.join(File.dirname(__FILE__), 'key_setup.rb'))
require File.expand_path(File.join(File.dirname(__FILE__),
          'pivotaltracker/pivotal_tracker.rb'))
require File.expand_path(File.join(File.dirname(__FILE__),
          'pivotaltracker/project.rb'))
require File.expand_path(File.join(File.dirname(__FILE__),
          'pivotaltracker/iteration.rb'))
require File.expand_path(File.join(File.dirname(__FILE__),
          'pivotaltracker/story.rb'))


#EphemeralResponse.deactivate

#require 'resto'
require 'pp'

puts "\n *********** Project ********** \n"
puts "Project.all"
projects = Project.all
project = projects.first
pp project.attributes



puts "\n *********** Iteration ********** \n"
puts "Iteration.all(1617, :limit => 10)"
iterations = Iteration.all(1617, :limit => 10)
pp iterations.first.attributes

puts "Iteration.current(1617)"
iteration = Iteration.current(1617)
pp iteration.first.attributes



puts "\n *************** Story ******************** \n"

puts "Story.post(attributes)"
attributes = {:story_type => 'feature',
              :name => 'User can log in again',
              :project_id => 255175,
              :requested_by  => 'unders'}

story = Story.post(attributes)
puts "story = Story.post attributes"
pp story.attributes

puts "story.project.stories(:limit => 30).first.attributes"
pp story.project.stories(:limit => 31).first.attributes

puts "story.reload"
s = story.reload
pp s.attributes

puts "story.body(:estimate => 2, :lables => 'elabs').put"
story = s.body(:estimate => 3, :lables => 'elabs').put
pp story.attributes

puts "Story.all(:limit => 3, :project_id => 255175)"
stories = Story.all(:limit => 3, :project_id => 255175)
pp stories.first.attributes


puts "story.delete"
story =  stories.first.delete

pp story.attributes

