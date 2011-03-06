# encoding: utf-8

require 'spec_helper'
require 'resto/extra/hash_args'

describe Resto::Extra::HashArgs do

  class_context(%Q{
    class BasicAuthication < Resto::Extra::HashArgs
      key :username
      key :password
    end}) do

    it "returns the value from the block when no value is found by key" do
      BasicAuthication.new(nil).fetch(:username) { 'anders' }.should == 'anders'
    end

    it "returns the value found by the key"  do
      BasicAuthication.new({'username' => 'anders', :password => 'secret'})
        .fetch(:password) { 'other' }.should == 'secret'
    end

    it "the key is translated to its symbol" do
      BasicAuthication.new({'username' => 'anders', :password => 'secret'})
        .fetch(:username) { 'other' }.should == 'anders'
    end
  end

  class_context(%Q{
    class FormatExt < Resto::Extra::HashArgs
      key :extension
    end}) do

    it "returns the value from the block" do
      FormatExt.new({}).fetch(:extension) { 'block' }.should == 'block'
    end

    if RUBY_VERSION < '1.9'

      it "raises IndexError when no value and no block" do
        expect { FormatExt.new({}).fetch(:extension) }
          .to raise_error(IndexError, 'key not found')
      end

    else

      it "raises KeyError when no value and no block" do
        lambda { FormatExt.new({}).fetch(:extension) }
          .should raise_error(KeyError, 'key not found: :extension')
      end

    end

    it "raises" do
      expect { FormatExt.new({:username => "anders"}) }
        .to raise_error(ArgumentError, /The key 'username'/)

      expect { FormatExt.new("string") }
        .to raise_error(ArgumentError, "'string' must be a Hash")

      expect { FormatExt.new(:extension => 'value', 'extension' => 'value') }
        .to raise_error(ArgumentError, "duplicated keys: extension, extension")

      expect { FormatExt.new({:invalid_key => 'invalid' }) }
        .to raise_error(ArgumentError, /The key 'invalid_key' is not valid/)

      expect { FormatExt.new({:extension => 'value' }).fetch(:invalid_key) }
        .to raise_error(ArgumentError, /The key 'invalid_key' is not valid/)
    end
  end
end
