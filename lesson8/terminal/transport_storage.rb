module Terminal
  class TransportStorage
    attr_reader :stations, :routes, :trains, :carriages

    def initialize
      @stations = []
      @routes = []
      @trains = []
      @carriages = []
    end

    def add_new_item(item)
      transport_item_storage(item) << item
    end

    def passenger_carriages
      carriages.select { |cr| cr.is_a? Transport::PassengerCarriage }
    end

    def cargo_carriages
      carriages.select { |cr| cr.is_a? Transport::CargoCarriage }
    end

    private

    def transport_item_storage(item)
      {
        'Transport::CargoTrain' => @trains,
        'Transport::PassengerTrain' => @trains,
        'Transport::Route' => @routes,
        'Transport::Station' => @stations,
        'Transport::CargoCarriage' => @carriages,
        'Transport::PassengerCarriage' => @carriages
      }.fetch(item.class.name)
    end
  end
end
