require './modules/validators/base_validator'
require './modules/validators/format_validator'
require './modules/validators/presence_validator'
require './modules/validators/type_validator'

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr, validation_type, param = nil)
      @@validations ||= []
      @@validations << BaseValidator.initialize_validator(validation_type,
                                                          attr.to_sym,
                                                          param)
    end

    def validations
      @@validations
    end
  end

  module InstanceMethods
    def validate!
      return unless self.class.validations

      validation_errors = self.class.validations
                              .reject { |item| item.valid?(self) }
                              .map(&:message)

      raise validation_errors.join(', ') if validation_errors.any?
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end
