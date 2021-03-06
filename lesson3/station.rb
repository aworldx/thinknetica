# describes a station to stop trains
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train)
  end

  def list_trains(type = nil)
    return trains unless type

    trains.select { |train| train.type == type }
  end
end
