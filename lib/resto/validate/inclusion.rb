# encoding: utf-8

module Resto
  module Validate
    class Inclusion
      include Validate

      def initialize
        @allow_nil = false
        @allow_blank = false
      end

      def in(range)
        tap { @range = range }
      end

      def allow_nil
        tap { @allow_nil = true }
      end

      def allow_blank
        tap { @allow_blank = true }
      end
    end
  end
end
#
# .in - An enumerable object of available items. %w( m f ), 0..99,  %w( jpg gif png )
# .message - Specifies a custom error message (default is: “is not included in the list”).
# .allow_nil - If set to true, skips this validation if the attribute is nil (default is false).
# .allow_blank - If set to true, skips this validation if the attribute is blank (default is false).
# .if - Specifies a method, proc or string to call to determine if the validation should occur
#      (e.g. :if => :allow_validation, or :if => Proc.new { |user| user.signup_step > 2 }). The method,
#      proc or string should return or evaluate to a true or false value.
# .unless - Specifies a method, proc or string to call to determine if the validation should not occur
#           (e.g. :unless => :skip_validation, or :unless => Proc.new { |user| user.signup_step <= 2 }).
#           The method, proc or string should return or evaluate to a true or false value.


