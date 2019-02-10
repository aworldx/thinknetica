module Transport
  class PassengerCarriage < Carriage
    prepend Validatable

    attr_reader :number, :seats_count, :empty_seats_count

    def initialize(params)
      @number = params[:number]
      @seats_count = params[:seats_count].to_i
      @empty_seats_count = params[:seats_count].to_i
    end

    def take_seat
      self.empty_seats_count -= 1
    end

    def taken_seats_count
      seats_count - empty_seats_count
    end

    def to_s
      "№#{number} PassengerCarriage, total seats count #{seats_count}, "\
      "empty seats count #{empty_seats_count}"
    end

    private

    attr_writer :empty_seats_count

    def validate!
      raise 'number must be filled' if number.empty?
      raise 'seats count must be filled' if seats_count.zero?
    end
  end
end
