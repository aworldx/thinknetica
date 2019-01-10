module Transport
  class Carriage
    include Manufacturer

    attr_accessor :number

    def initialize(number = '')
      @number = number
    end
  end
end
