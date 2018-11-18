module Terminal
  class CreateCommand < BaseCommand
    def run
      puts "Command executing: #{name}..."

      create_class = if options[:types].size > 1
                       puts 'Select type'
                       select_object(options[:types])
                     else
                       options[:types].first
                     end

      new_instance = create_class.new

      options[:attrs].each do |attr|
        new_val = if attr[:select_type] == :text
                    puts "Pleese enter the value of #{attr[:title]}"
                    gets.chomp
                  elsif attr[:select_type] == :select
                    puts "Select #{attr[:title]}"
                    select_object(attr[:select_arr])
                  end

        return unless new_val

        new_instance.send("#{attr[:title]}=", new_val)
      end

      puts "#{create_class} was made successfully: #{new_instance}"
      new_instance
    end
  end
end
