class TypeValidator < BaseValidator
  def valid?(object)
    return true unless attr_value(object)

    attr_value(object).class.to_s == param.to_s
  end

  def message
    "wrong type for attribute #{attribute}"
  end
end
