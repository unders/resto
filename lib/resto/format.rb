require 'resto/format/default'
require 'resto/format/plain'
require 'resto/format/www_form'
require 'resto/format/json'

module Resto
  module Format
    def accept; '*/*';             end
    def content_type;              end
    def decode(*args); args;       end
    def encode(*args); args.first; end
    def extension;                 end
  end
end

