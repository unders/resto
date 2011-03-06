# encoding: utf-8

module Resto
  module Validate

    autoload :Inclusion,  'resto/validate/inclusion'
    autoload :Length,     'resto/validate/length'
    autoload :Presence,   'resto/validate/presence'

    def initialize
      @if     = lambda { |resource| true  }
      @unless = lambda { |resource| false }
    end

    def validate?(resource)
      (@if.call(resource) && !@unless.call(resource))
    end

    def message(error_message)
      tap { @message = error_message }
    end

    def if(&block)
      tap { @if = block }
    end

    def unless(&block)
      tap { @unless = block }
    end

    # .on - Specifies when this validation is active (default is :save, other
    # options :create, :update).
    # def on(args)
    #  tap { }
    # end
  end
end
