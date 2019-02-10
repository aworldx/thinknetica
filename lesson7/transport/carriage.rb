module Transport
  class Carriage
    include Manufacturer
    prepend Validatable

    attr_accessor :number

    def initialize(params)
      @number = params[:number]
    end
  end
end
