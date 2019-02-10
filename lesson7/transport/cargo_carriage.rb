module Transport
  class CargoCarriage < Carriage
    prepend Validatable

    attr_reader :number, :capacity, :empty_capacity

    def initialize(params)
      @number = params[:number]
      @capacity = params[:capacity].to_f
      @empty_capacity = params[:capacity].to_f
    end

    def take_capacity(capacity)
      return unless capacity.respond_to? :to_f

      self.empty_capacity -= capacity.to_f
    end

    def taken_capacity
      capacity - empty_capacity
    end

    def to_s
      "№#{number} CargoCarriage, total capacity #{capacity}, "\
      "empty capacity #{empty_capacity}"
    end

    private

    attr_writer :empty_capacity

    def validate!
      raise 'number must be filled' if number.empty?
      raise 'capacity must be filled' if capacity.zero?
    end
  end
end
