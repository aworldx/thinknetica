module Transport
  class Carriage
    include Manufacturer
    include Validatable

    attr_accessor :number

    def initialize(number = '')
      @number = number

      super
    end

    def valid?
      false
    end
  end
end
