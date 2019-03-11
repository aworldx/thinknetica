require './transport/manufacturer'
require './terminal/instance_counter'
require './modules/accessors'
require './modules/validation'

# describes freight or passenger trains
module Transport
  class Train
    TRAIN_NUMBER_CHECK = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i

    include Manufacturer
    include InstanceCounter
    include Acсessors
    include Validation

    attr_reader :speed, :route, :current_station, :carriages
    attr_accessor_with_history :number, :driver
    strong_attr_accessor :manufacture_date, 'Date'

    validate :number, :presence
    validate :number, :format, TRAIN_NUMBER_CHECK
    validate :number, :type, String

    def initialize(params = {})
      @number = params[:number]
      @carriages = []
      @speed = 0

      register_instance
    end

    def self.find(number)
      instance_storage.find { |train| train.number == number }
    end

    def speed_up(speed)
      self.speed = speed
    end

    def speed_down
      self.speed = 0
    end

    def moving?
      speed > 0
    end

    def add_route(route)
      self.route = route
      self.current_station = route.first_station
      current_station.add_train(self)
    end

    def go_to_next_station
      next_st = route.next_station(current_station, :forward)

      raise "there's nowhere to go" unless next_st

      current_station.remove_train(self)
      self.current_station = next_st
      current_station.add_train(self)
    end

    def go_to_previous_station
      prev_st = route.next_station(current_station, :backward)

      raise "there's nowhere to go" unless prev_st

      current_station.remove_train(self)
      self.current_station = prev_st
      current_station.add_train(self)
    end

    def next_station
      route.next_station(current_station, :forward)
    end

    def previous_station
      route.next_station(current_station, :backward)
    end

    def to_s
      "Train №#{number}"
    end

    def each_carriage
      return unless block_given?

      carriages.each { |cr| yield(cr) }
    end

    private

    # def validate!
    #   raise 'number does not match the pattern' unless number =~ TRAIN_NUMBER_CHECK
    # end

    # only child classes call this method
    def add_carriage(carriage)
      raise 'Train is moving now!' if moving?

      @carriages << carriage
    end

    # only child classes call this method
    def remove_carriage(carriage)
      raise 'Train is moving now!' if moving?
      raise 'No carriages on the train' if carriages.empty?

      @carriages.delete(carriage)
    end

    # can't directly change this data, use methods
    attr_writer :speed, :carriage_count, :route, :current_station
  end
end
