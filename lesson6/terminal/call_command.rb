module Terminal
  class CallCommand < BaseCommand
    def run
      puts "Command executing: #{name}..."

      if options[:objects].empty?
        puts 'Error: There is no objects to select!!!'
        return
      end

      puts 'Please select object'
      reciever = select_object(options[:objects])

      if options[:arg]
        puts 'Please select object'
        argument = select_object(options[:arg])

        puts reciever.send(options[:method], argument)
      else
        puts reciever.send(options[:method])
      end

      puts 'Command was executed successfully'
    end
  end
end
