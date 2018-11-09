# route contains stations fot trains stops
class Route
  attr_reader :transitional_stations

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

  def first_station(direction = :forward)
    direction == :forward ? @first_station : @last_station
  end

  def last_station(direction = :forward)
    direction == :forward ? @last_station : @first_station
  end

  def next_station(station, direction = :forward)
    return if station == last_station(direction)

    if transitional_stations.empty? || station == last_trans_station(direction)
      return last_station(direction)
    end

    return first_trans_station(direction) if station == first_station(direction)

    index_increase = (direction == :forward ? 1 : -1)
    transitional_stations[station_index(station) + index_increase]
  end

  private

  def station_index(station)
    transitional_stations.index(station)
  end

  def first_trans_station(direction = :forward)
    return if transitional_stations.empty?

    direction == :forward ? transitional_stations.first : transitional_stations.last
  end

  def last_trans_station(direction = :forward)
    return if transitional_stations.empty?

    direction == :forward ? transitional_stations.last : transitional_stations.first
  end
end
