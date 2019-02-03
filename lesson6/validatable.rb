module Validatable
  def initialize(params = {})
    super(params)
    raise 'object is not valid!' unless valid?
  end

  def valid?
    super
  end
end
