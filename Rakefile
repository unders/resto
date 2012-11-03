#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.fail_on_error = true
  t.verbose = true
  t.rspec_opts = ["-r ./spec/spec_helper", "--color"]
  #t.ruby_opts = ["-w"]
end

task :test => :spec
task :default => :test

desc  "open console (require 'resto')"
task :c do
  system "irb -I lib -r resto"
end
