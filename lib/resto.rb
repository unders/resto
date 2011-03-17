# encoding: utf-8

require 'resto/request/base'
require 'resto/response/base'
require 'resto/property'
require 'resto/attributes'
require 'resto/extra/copy'

module Resto
  def self.included(klass)
    klass.extend ClassMethods
    klass.class_eval do
      @request  = Request::Base.new
      @response = Response::Base.new.klass(klass)
    end
  end

  def self.url(url)
    Request::Base.new.url(url)
  end
end

module Resto
  module ClassMethods

    def inherited(sub_class)
      sub_class.class_exec(self) do |parent_class|
        @request   = parent_class.request
        @response  = parent_class.base_response.klass(sub_class)
      end
    end

    def resto_request(&block)
      @request.instance_exec(&block)
    end


    def resto_response(&block)
      @response.instance_exec(&block)
    end

    def resource_id
      @resource_identifier
    end

    def resource_identifier(id)
      @resource_identifier = id
    end

    def property(name, property, options={}, &block)
      property = Resto::Property.const_get(property.to_s).new(name, options)
      property.instance_exec(&block) if block_given?

      property_handler.add(property)

      attribute_methods = %Q{
        def #{name}
          @attributes.get(:#{name})
        end

        def #{name}_without_cast
          @attributes.get_without_cast(:#{name})
        end

        def #{name}?
          @attributes.present?(:#{name})
        end

        def #{name}=(value)
          @attributes.set(:#{name}, value)
        end
      }

      class_eval(attribute_methods, __FILE__, __LINE__)
    end


    def all(params = {})
      res =
        if params.keys.empty?
          request.get
        else
          request.params(params).get
        end

      response(res).all
    end

    def head
      response(request.head)
    end

    def get(id)
      response(request.append_path(id).get).get
    end

    def fetch(params = {})
      res =
        if params.keys.empty?
          request.get
        else
          request.params(params).get
        end

      response(res).get
    end

    def post(attributes)
      attributes.delete(resource_id)
      remote_attributes = property_handler.remote_attributes(attributes)
      response(request.body(remote_attributes).post).get
    end

    def put(attributes)
      id = attributes.delete(resource_id)
      remote_attributes = property_handler.remote_attributes(attributes)
      response(request.append_path(id).body(remote_attributes).put).get
    end

    def delete(id)
      response(request.append_path(id).delete).get
    end

    def request
      Extra::Copy.request_base(@request)
    end

    def response(response)
      base_response.http_response(response)
    end

    def base_response
      Extra::Copy.response_base(@response)
    end

    def property_handler
      @property_handler ||= Property::Handler.new
    end

  end
end

module Resto
  def initialize(attributes)
    raise "Must be a hash" unless attributes.is_a?(Hash)

    @attributes = Attributes.new(attributes, self)
  end

  attr_accessor :response

  def get
    id = attributes.fetch(self.class.resource_id)
    self.class.get(id)
  end

  alias reload get

  def put
    self.class.put(attributes)
  end

  def delete
    id = attributes.fetch(self.class.resource_id)
    self.class.delete(id)
  end

  def valid?
    @attributes.valid? and valid_response?(false)
  end

  def valid_response?(must_have_a_response_variable=true)
    if must_have_a_response_variable
      response ? response.valid? : false
    else
      response ? response.valid? : true
    end
  end

  def add_error(key, value)
    @attributes.add_error(key, value)
  end

  def errors
    @attributes.errors
  end

  def update_attributes(attributes)
    tap { @attributes.update_attributes(attributes) }
  end

  alias body update_attributes

  def attributes
    @attributes.to_hash
  end

end
