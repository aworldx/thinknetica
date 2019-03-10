class FormatValidator < BaseValidator
  def valid?(object)
    return true unless attr_value(object)
    return false unless attr_value(object).respond_to?(:to_s)

    attr_value(object).to_s =~ param
  end

  def message
    "wrong format for attribute #{attribute}"
  end
end
