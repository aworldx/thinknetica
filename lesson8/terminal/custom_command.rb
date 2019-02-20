module Terminal
  class CustomCommand < BaseCommand
    def run
      puts "Command executing: #{name}..."

      if options[:objects].empty?
        puts 'Error: There is no objects to select!!!'
        return
      end

      puts 'Please select object'
      reciever = select_object(options[:objects])

      options[:proc].call(reciever)

      puts 'Command was executed successfully'
    end
  end
end
