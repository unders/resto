# -*- encoding: utf-8 -*-
require 'simplecov'
SimpleCov.start
require "rubygems"
require "bundler/setup"
require "rspec"
require 'resto'
require 'webmock/rspec'
require 'yajl'

Bundler.require :default

RSpec.configure do |c|
  c.mock_with :rspec
  c.include WebMock
  c.fail_fast = true
end

# Helper methods
def basic_encode(account, password)
  'Basic ' + ["#{account}:#{password}"].pack('m').delete("\r\n")
end

def headers(options = {})
  {'accept' => '*/*', 'user-agent' => 'Ruby'}.merge(options)
end

def eval_context(string, &block)
  eval(string)
  context(string, &block)
end

def class_context(klass, &block)
  eval_context(klass, &block)
end

def to_json(hash)
  Yajl::Encoder.encode(hash)
end

class Hash
  def to_json
    Yajl::Encoder.encode(self)
  end
end

class Array
  def to_json
    Yajl::Encoder.encode(self)
  end
end
