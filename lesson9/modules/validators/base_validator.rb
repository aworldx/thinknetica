class BaseValidator
  attr_reader :attribute, :param

  def initialize(attribute, param)
    @attribute = attribute
    @param = param
  end

  def valid?
    raise 'unknown validation type'
  end

  alias message valid?

  def attr_value(object)
    object.instance_variable_get("@#{attribute}")
  end

  def self.initialize_validator(validation_type, attribute, params)
    klass = Object.const_get "#{validation_type.capitalize}Validator"
    klass.new(attribute, params)
  rescue NameError
    new(attribute, params)
  end
end
