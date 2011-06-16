require 'bundler'
Bundler::GemHelper.install_tasks

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

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
