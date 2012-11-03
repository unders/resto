# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resto/version'

Gem::Specification.new do |gem|
  gem.name          = "resto"
  gem.version       = Resto::VERSION
  gem.authors       = ["Anders Törnqvist"]
  gem.email         = ["anders@elabs.se"]
  gem.description   = %q{Restful Web Service}
  gem.summary       = %q{Restful Web Service}
  gem.homepage      = "https://github.com/unders/resto"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "hamster", "~> 0.4.3"
  gem.add_runtime_dependency "virtus", "~> 0.5.2"
  
  gem.add_development_dependency "rspec", "~> 2.11.0"
end
