# encoding: utf-8

module Resto
  module Format

    # @note When no format is selected this class is used by the
    #  {Request::Base} and {Response::Base} objects.
    #
    # This class includes the methods from the {Resto::Format} module without
    # any change.
    class Default; end

    class << Default
      include Format
    end
  end
end
