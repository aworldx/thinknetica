class PresenceValidator < BaseValidator
  def valid?(object)
    !attr_value(object).nil?
  end

  def message
    "attribute #{attribute} must be presented"
  end
end
