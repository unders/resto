# encoding: utf-8

require File.expand_path("../lib/resto/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "resto"
  s.version     = Resto::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Anders Törnqvist"]
  s.email       = ["anders@elabs.se"]
  s.homepage    = "https://github.com/unders/resto"
  s.summary     = "Restful Web Service"
  s.description = "Restful Web Service"

  s.required_ruby_version = ::Gem::Requirement.new(">= 1.8.7")
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "resto"

  s.add_runtime_dependency "yajl-ruby", ">= 0.8.2"
  s.add_runtime_dependency "nokogiri", ">=1.4.4"
  # s.add_dependency "activesupport", "3.0.0" ???
  s.add_development_dependency "bundler", ">= 1.0.13"
  s.add_development_dependency "rspec",   ">= 2.6.0"
  s.add_development_dependency "fuubar",   ">= 0.0.4"
  s.add_development_dependency "webmock", ">= 1.6.2"
  s.add_development_dependency "code-cleaner", ">= 0.8.2"
  s.add_development_dependency "reek"
  s.add_development_dependency "metrical"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "ephemeral_response"
  s.add_development_dependency "rake", "0.8.7"

  # CLI testing
  # http://github.com/radar/guides/blob/master/gem-development.md
  # s.add_dependency "thor"
  # s.add_development_dependency "cucumber"
  # s.add_development_dependency "aruba"

  s.files = Dir.glob("{lib,spec}/**/*") + %w(resto.gemspec)
  # s.files        = `git ls-files`.split("\n")
  # s.executables  = `git ls-files`.split("\n").map do |f|
  #   f =~ /^bin\/(.*)/ ? $1 : nil
  # end.compact
  s.require_path = 'lib'
end
