module Transport
  class Carriage
    include Manufacturer
    prepend Validatable

    attr_reader :number, :places_count, :empty_places
    attr_accessor :empty_places

    def initialize(params)
      @number = params[:number]
      @places_count = params[:places_count].to_f
      @empty_places = params[:places_count].to_f
    end

    def take_place(count)
      return unless count.respond_to? :to_f

      self.empty_places -= count.to_f
    end

    def taken_capacity
      places_count - empty_places
    end

    def to_s
      "№#{number} #{self.class}, total places #{places_count}, "\
      "empty places #{empty_places}"
    end

    private

    def validate!
      raise 'number must be filled' if number.empty?
      raise 'places_count must be filled' if places_count.zero?
    end
  end
end
