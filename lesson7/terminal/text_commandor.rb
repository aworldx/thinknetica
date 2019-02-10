# text interface for transport manipulation
module Terminal
  class TextCommandor
    def initialize(storage)
      @commands = []
      @storage = storage
    end

    def add_menu_item(name, type, options = {})
      @commands << command_dispatcher(type).new(name, type, options)
    end

    def execute(menu_item_index)
      command = menu_item_by_index(menu_item_index)
      result = command.run

      @storage.add_new_item(result) if command.type == :create && result
    end

    def print_menu
      puts "Enter command index or type 'stop' to exit"

      @commands.each.with_index(1) do |command, ind|
        puts "#{ind}. #{command.name}"
      end
    end

    def load_menu
      add_menu_item('Station create',
                    :create,
                    types: [Transport::Station],
                    attrs: [{ title: 'name', select_type: :text }])

      add_menu_item('Train create',
                    :create,
                    types: [Transport::CargoTrain, Transport::PassengerTrain],
                    attrs: [{ title: 'number', select_type: :text }])

      add_menu_item('Route create',
                    :create,
                    types: [Transport::Route],
                    attrs: [{ title: 'first_station',
                              select_type: :select,
                              select_arr: @storage.stations },
                            { title: 'last_station',
                              select_type: :select,
                              select_arr: @storage.stations }])

      add_menu_item('Passenger carriage create',
                    :create,
                    types: [Transport::PassengerCarriage],
                    attrs: [{ title: 'number', select_type: :text },
                            { title: 'seats_count', select_type: :text }])

      add_menu_item('Cargo carriage create',
                    :create,
                    types: [Transport::CargoCarriage],
                    attrs: [{ title: 'number', select_type: :text },
                            { title: 'capacity', select_type: :text }])

      add_menu_item('Add station to route',
                    :call,
                    objects: @storage.routes,
                    method: :add_transitional_station,
                    arg: @storage.stations)

      add_menu_item('Remove station from route',
                    :call,
                    objects: @storage.routes,
                    method: :remove_transitional_station,
                    arg: @storage.stations)

      add_menu_item('Set route for the train',
                    :call,
                    objects: @storage.trains,
                    method: :add_route,
                    arg: @storage.routes)

      add_menu_item('Add carriage for the train',
                    :call,
                    objects: @storage.trains,
                    method: :add_carriage,
                    arg: @storage.carriages)

      add_menu_item('Remove carriage from the train',
                    :call,
                    objects: @storage.trains,
                    method: :remove_carriage,
                    arg: @storage.carriages)

      add_menu_item('Move the train forward',
                    :call,
                    objects: @storage.trains,
                    method: :go_to_next_station)

      add_menu_item('Move the train backward',
                    :call,
                    objects: @storage.trains,
                    method: :go_to_previous_station)

      add_menu_item('Check train current station',
                    :call,
                    objects: @storage.trains,
                    method: :current_station)

      add_menu_item('Check station list',
                    :list,
                    objects: @storage.stations)

      add_menu_item('Check trans stations of the route',
                    :call,
                    objects: @storage.routes,
                    method: :transitional_stations)

      add_menu_item('Check trains on the station',
                    :custom,
                    objects: @storage.stations,
                    proc: proc { |station| station.each_train { |tr| puts tr } })

      add_menu_item('Check carriage list',
                    :custom,
                    objects: @storage.trains,
                    proc: proc { |train| train.each_carriage { |cr| puts cr } })

      add_menu_item('Take passenger carriage seat or cargo carriage capacity',
                    :custom,
                    objects: @storage.carriages,
                    proc: proc do |carriage|
                      return unless carriage

                      if carriage.is_a?(Transport::CargoCarriage)
                        puts 'Please enter capacity'
                        capacity = gets.chomp

                        carriage.take_capacity(capacity)
                      else
                        carriage.take_seat
                      end
                    end)

    end

    private

    def command_dispatcher(type)
      {
        create: CreateCommand,
        call: CallCommand,
        list: ListCommand,
        custom: CustomCommand
      }.fetch(type, BaseCommand)
    end

    def menu_item_by_index(menu_item_index)
      @commands[menu_item_index - 1]
    end
  end
end
