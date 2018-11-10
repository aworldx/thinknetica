module Transport
  class CargoTrain < Train
    def add_carriage(carriage)
      raise 'Wrong carriage type!' unless type_check? carriage
      super
    end

    def to_s
      "CargoTrain №#{number}"
    end

    private

    # helper method, uses only in this class
    def type_check?(carriage)
      carriage.is_a?(CargoCarriage)
    end
  end
end
