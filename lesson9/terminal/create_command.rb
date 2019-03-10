module Terminal
  class CreateCommand < BaseCommand
    def run
      greeting
      @entity_type = select_entity_type
      @new_instance = create_instance
      bye

      @new_instance
    end

    private

    def bye
      puts "#{@entity_type} was made successfully: #{@new_instance}"
    end

    def select_entity_type
      if options[:types].size > 1
        puts 'Select type'
        select_object(options[:types])
      else
        options[:types].first
      end
    end

    def create_instance
      new_instance = nil

      loop do
        begin
          new_instance = @entity_type.new(select_params)
          break
        rescue RuntimeError => e
          puts "#{e.message}, try again!"
        end
      end

      new_instance
    end

    def select_params
      options[:attrs].each_with_object({}) do |attr_options, memo|
        key = attr_options[:title].to_sym

        memo[key] = input_param(attr_options)
      end
    end

    def input_param(attr_options)
      if attr_options[:select_type] == :text
        puts "Please enter the value of #{attr_options[:title]}"
        gets.chomp
      elsif attr_options[:select_type] == :select
        puts "Select #{attr_options[:title]}"
        select_object(attr_options[:select_arr])
      end
    end
  end
end
