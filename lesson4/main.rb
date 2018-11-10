require 'byebug'
require './terminal/text_commandor'
require './terminal/base_command'
require './terminal/create_command'
require './terminal/call_command'
require './terminal/list_command'
require './transport/train'
require './transport/cargo_train'
require './transport/passenger_train'
require './transport/carriage'
require './transport/cargo_carriage'
require './transport/passenger_carriage'
require './transport/station'
require './transport/route'

term = Terminal::TextCommandor.new
term.load_menu

loop do
  term.print_menu
  command_index = gets.chomp

  break if command_index == 'stop'

  term.execute(command_index.to_i)
end
