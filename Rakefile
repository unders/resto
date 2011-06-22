require 'bundler'
Bundler::GemHelper.install_tasks

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rspec/core/rake_task'

desc  "open console (require 'resto')"
task :c do
  system "irb -I lib -r resto"
end

desc  "adds encoding utf-8.."
task :clean do
  system "code-cleaner . --encoding=utf-8"
end

desc "Runs all the specs."
task :spec => :clean do
  system "bundle exec rspec spec"
end

task :default do
  system "bundle exec rspec spec"
end

task :test => :default

namespace :spec do
  desc "Run spec with warnings"
  RSpec::Core::RakeTask.new('spec') do |t|
    t.ruby_opts = "-w"
  end
end



