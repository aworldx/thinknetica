class CallCommand < BaseCommand
  def run
    puts "Command executing: #{name}..."

    puts 'Please select object'
    reciever = select_object(options[:objects])

    if options[:arg]
      puts 'Please select object'
      argument = select_object(options[:arg])

      reciever.send(options[:method], argument)
    else
      reciever.send(options[:method])
    end

    puts 'Command was executed successfully'
  end
end
