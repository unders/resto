# -*- encoding: utf-8 -*-
require 'simplecov'
SimpleCov.start
require "rubygems"
require "bundler/setup"
require "rspec"
require 'resto'
require 'webmock/rspec'
require 'yajl'
require 'time'

Bundler.require :default

RSpec.configure do |c|
  c.mock_with :rspec
  c.include WebMock::API
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

# Copied from https://github.com/notahat/time_travel
module TimeTravel
  module TimeExtensions

    def self.included(base)
      base.extend(ClassMethods)
      base.class_eval do
        class << self
          alias_method :immutable_now, :now
          alias_method :now, :mutable_now
        end
      end
      base.now = nil
    end

    module ClassMethods

      @@now = nil
      @@simulated_offset = nil

      def now=(value)
        @@now = value.is_a?(String) ? parse(value) : value
      end

      def mutable_now
        @@now || immutable_now
      end

      def simulated_offset=(offset)
        @@simulated_offset = offset
      end

      def simulated_offset
        @@simulated_offset
      end

    end
  end
end

class Time
  include TimeTravel::TimeExtensions

  def new_local_time
    if self.class.simulated_offset
      old_localtime(self.class.simulated_offset)
    else
      old_localtime
    end
  end

  alias_method :old_localtime, :localtime
  alias_method :localtime, :new_local_time

end

def at_time(time, offset=nil)
  Time.simulated_offset = offset
  Time.now = time
  begin
    yield Time.now
  ensure
    Time.now = nil
    Time.simulated_offset = nil
  end
end
