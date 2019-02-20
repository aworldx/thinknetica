module Transport
  class PassengerCarriage < Carriage
    def take_place(_count)
      super(1)
    end
  end
end
