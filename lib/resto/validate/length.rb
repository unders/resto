# encoding: utf-8

module Resto
  module Validate
    class Length
      include Validate

      def is(number)
        tap { @number = number }
      end

    end
  end
end
# .is - The exact size of the attribute.
# .within - A range specifying the minimum and maximum size of the attribute.
# .allow_nil - Attribute may be nil; skip validation.
# .allow_blank - Attribute may be blank; skip validation.
# .if - Specifies a method, proc or string to call to determine if the
# validation should occur (e.g. :if => :allow_validation, or :if =>
# Proc.new { |user| user.signup_step > 2 }). The method, proc or string should
# return or evaluate to a true or false value.
# .unless - oposite of .if
#
# messages
# :too_long - The error message if the attribute goes over the maximum
# (default is: “is too long (maximum is %count characters)”).
# :too_short - The error message if the attribute goes under the minimum
# (default is: “is too short (min is %count characters)”).
# :wrong_length - The error message if using the :is method and the attribute
# is the wrong size (default is: “is the wrong length
# (should be %count characters)”).
# :message - The error message to use for a :minimum, :maximum, or
# :is violation. An alias of the appropriate too_long/too_short/wrong_length
# message.

