# text interface for transport manipulation
module Terminal
  class TextCommandor
    attr_reader :commands, :stations, :routes, :trains, :carriages

    def initialize
      @commands = []
      @stations = []
      @routes = []
      @trains = []
      @carriages = []
    end

    def add_menu_item(name, type, options = {})
      @commands << command_dispatcher(type).new(name, type, options)
    end

    def execute(menu_item_index)
      command = menu_item_by_index(menu_item_index)
      result = command.run

      add_new_instance(result) if command.type == :create
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
                              select_arr: stations },
                            { title: 'last_station',
                              select_type: :select,
                              select_arr: stations }])

      add_menu_item('Carriage create',
                    :create,
                    types: [Transport::CargoCarriage, Transport::PassengerCarriage],
                    attrs: [{ title: 'number', select_type: :text }])

      add_menu_item('Add station to route',
                    :call,
                    objects: routes,
                    method: :add_transitional_station,
                    arg: stations)

      add_menu_item('Remove station from route',
                    :call,
                    objects: routes,
                    method: :remove_transitional_station,
                    arg: stations)

      add_menu_item('Set route for the train',
                    :call,
                    objects: trains,
                    method: :add_route,
                    arg: routes)

      add_menu_item('Add carriage for the train',
                    :call,
                    objects: trains,
                    method: :add_carriage,
                    arg: carriages)

      add_menu_item('Check carriage list',
                    :call,
                    objects: trains,
                    method: :print_carriage_list)

      add_menu_item('Remove carriage from the train',
                    :call,
                    objects: trains,
                    method: :remove_carriage,
                    arg: carriages)

      add_menu_item('Move the train forward',
                    :call,
                    objects: trains,
                    method: :go_to_next_station)

      add_menu_item('Move the train backward',
                    :call,
                    objects: trains,
                    method: :go_to_previous_station)

      add_menu_item('Check train current station',
                    :call,
                    objects: trains,
                    method: :print_current_station)

      add_menu_item('Check station list',
                    :list,
                    objects: stations)

      add_menu_item('Check trains on the station',
                    :call,
                    objects: stations,
                    method: :trains_on_station)

      add_menu_item('Check trans stations of the route',
                    :call,
                    objects: routes,
                    method: :print_transitional_stations)
    end

    private

    def command_dispatcher(type)
      {
        create: CreateCommand,
        call: CallCommand,
        list: ListCommand
      }.fetch(type, BaseCommand)
    end

    def menu_item_by_index(menu_item_index)
      @commands[menu_item_index - 1]
    end

    def transport_classes
      {
        'Transport::CargoTrain' => @trains,
        'Transport::PassengerTrain' => @trains,
        'Transport::Route' => @routes,
        'Transport::Station' => @stations,
        'Transport::CargoCarriage' => @carriages,
        'Transport::PassengerCarriage' => @carriages
      }
    end

    def add_new_instance(instance)
      transport_classes[instance.class.name] << instance
    end
  end
end
