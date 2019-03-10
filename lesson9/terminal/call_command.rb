module Terminal
  class CallCommand < BaseCommand
    def run
      greeting
      @receiver = select_receiver
      return unless @receiver

      call_receiver_method
      bye
    end

    private

    def select_receiver
      if options[:objects].empty?
        puts 'Error: There is no objects to select!!!'
        return
      end

      puts 'Please select object'
      select_object(options[:objects])
    end

    def select_arg
      if options[:arg].is_a?(Array)
        puts 'Please select object'
        select_object(options[:arg])
      else
        puts "Please enter #{options[:arg]}"
        gets.chomp
      end
    end

    def call_receiver_method
      if options[:arg]
        argument = select_arg

        puts @receiver.send(options[:method], argument)
      else
        puts @receiver.send(options[:method])
      end
    end
  end
end
