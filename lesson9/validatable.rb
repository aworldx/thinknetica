# old implementation of validation
module Validatable
  def initialize(params = {})
    super(params)

    validate!
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def validate!
    super
  end
end
