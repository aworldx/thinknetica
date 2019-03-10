# describes a station to stop trains
module Transport
  class Station
    include InstanceCounter

    attr_reader :trains
    attr_accessor :name

    def initialize(params = {})
      @name = params[:name]
      @trains = []

      register_instance
    end

    def self.all
      instance_storage
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

    def to_s
      "Station #{name.capitalize}"
    end

    def each_train
      return unless block_given?

      trains.each { |train| yield(train) }
    end

    private

    def validate!
      raise 'station name must be filled' if name.strip.empty?
    end
  end
end
