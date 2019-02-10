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

      new_instance = nil

      loop do
        params = user_input

        begin
          new_instance = create_class.new(params)
          break
        rescue RuntimeError => e
          puts "#{e.message}, try again!"
        end
      end

      puts "#{create_class} was made successfully: #{new_instance}"
      new_instance
    end

    def user_input
      options[:attrs].each_with_object({}) do |attr, memo|
        key = attr[:title].to_sym

        memo[key] = if attr[:select_type] == :text
                      puts "Pleese enter the value of #{attr[:title]}"
                      gets.chomp
                    elsif attr[:select_type] == :select
                      puts "Select #{attr[:title]}"
                      select_object(attr[:select_arr])
                    end
      end
    end
  end
end
