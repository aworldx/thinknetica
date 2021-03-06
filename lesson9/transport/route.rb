# route contains stations fot trains stops
module Transport
  class Route
    include InstanceCounter

    attr_reader :transitional_stations
    attr_writer :first_station, :last_station

    def initialize(params = {})
      @first_station = params[:first_station]
      @last_station = params[:last_station]

      @transitional_stations = []

      register_instance
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

    # rubocop:disable Metrics/AbcSize
    def next_station(station, direction = :forward)
      return if station == last_station(direction)

      return last_station(direction) if transitional_stations.empty?
      return last_station(direction) if station == last_trans_station(direction)
      return first_trans_station(direction) if station == first_station(direction)

      index_increase = (direction == :forward ? 1 : -1)
      transitional_stations[station_index(station) + index_increase]
    end
    # rubocop:enable Metrics/AbcSize

    def to_s
      "Route from #{first_station} to #{last_station}"
    end

    private

    def validate!
      raise "route's stations must be filled" unless first_station && last_station
      raise 'stations in the route can not be equal' if first_station == last_station
    end

    # helper method, uses only in this class
    def station_index(station)
      transitional_stations.index(station)
    end

    # helper method, uses only in this class
    def first_trans_station(direction = :forward)
      return if transitional_stations.empty?

      direction == :forward ? transitional_stations.first : transitional_stations.last
    end

    # helper method, uses only in this class
    def last_trans_station(direction = :forward)
      return if transitional_stations.empty?

      direction == :forward ? transitional_stations.last : transitional_stations.first
    end
  end
end
