# describes freight or passenger trains
class Train
  attr_reader :speed, :carriage_count, :route, :current_station, :number, :type

  def initialize(number, type = 'грузовой', carriage_count = 10)
    @number = number
    @type = type
    @carriage_count = carriage_count
    @speed = 0
  end

  def speed_up(speed)
    @speed = speed
  end

  def speed_down
    @speed = 0
  end

  def moving?
    speed > 0
  end

  def add_carriage
    raise 'Train is moving now!' if moving?

    @carriage_count += 1
  end

  def remove_carriage
    raise 'Train is moving now!' if moving?
    raise 'No carriages on the train' if carriage_count.zero?

    @carriage_count -= 1
  end

  def route=(route)
    @route = route
    @current_station = route.first_station
    @current_station.add_train(self)
  end

  def go_to_next_station
    next_st = route.next_station(current_station, :forward)

    raise "there's nowhere to go" unless next_st

    @current_station.remove_train(self)
    @current_station = next_st
    @current_station.add_train(self)
  end

  def go_to_previous_station
    prev_st = route.next_station(current_station, :backward)

    raise "there's nowhere to go" unless prev_st

    @current_station.remove_train(self)
    @current_station = prev_st
    @current_station.add_train(self)
  end

  def next_station
    route.next_station(current_station, :forward)
  end

  def previous_station
    route.next_station(current_station, :backward)
  end

  # def ==(other)
  #   number == other.number
  # end
end
