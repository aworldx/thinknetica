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
        argument = if options[:arg].is_a?(Array)
                     puts 'Please select object'
                     select_object(options[:arg])
                   else
                     puts "Please enter #{options[:arg]}"
                     gets.chomp
                   end

        puts reciever.send(options[:method], argument)
      else
        puts reciever.send(options[:method])
      end

      puts 'Command was executed successfully'
    end
  end
end
