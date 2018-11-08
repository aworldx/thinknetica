# route contains stations fot trains stops
class Route
  attr_reader :transitional_stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station

    @transitional_stations = []
  end

  def add_transitional_station(station)
    @transitional_stations << station
  end

  def remove_transitional_station(station)
    @transitional_stations.delete(station)
  end

  def next_station(station)
    raise nil if station == last_station

    if transitional_stations.empty? || station == transitional_stations[-1]
      return last_station
    end

    return transitional_stations.first if station == first_station

    transitional_stations[station_index(station) + 1]
  end

  def previous_station(station)
    raise nil if station == first_station

    if transitional_stations.empty? || station == transitional_stations.first
      return first_station
    end

    return transitional_stations.last if station == last_station

    transitional_stations[station_index(station) - 1]
  end

  private

  def station_index(station)
    transitional_stations.index(station)
  end
end
