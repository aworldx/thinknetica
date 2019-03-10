# base class for commands, null object
module Terminal
  class BaseCommand
    attr_reader :name, :options, :type

    def initialize(name, type, options = {})
      @name = name
      @options = options
      @type = type
    end

    def run
      puts 'This is base command! It does not make smth useful'
    end

    protected

    def greeting
      puts "Command executing: #{name}..."
    end

    def bye
      puts 'Command was executed successfully'
    end

    private

    def select_object(source)
      if source.empty?
        puts 'There is no objects for select'
        return
      end

      source.each.with_index(1) { |obj, index| puts "#{index}. #{obj}" }

      selected = gets.chomp.to_i
      source[selected - 1]
    end
  end
end
