require 'byebug'
require './station'
require './route'
require './train'

# station Имеет название, которое указывается при ее создании
st1 = Station.new('Station 1')
st2 = Station.new('Station 2')
st3 = Station.new('Station 3')
st4 = Station.new('Station 4')
st5 = Station.new('Station 5')

# Имеет номер (произвольная строка) и тип (грузовой, пассажирский)
# и количество вагонов, эти данные указываются при создании экземпляра класса
train1 = Train.new(1)
train2 = Train.new(2, 'грузовой', 100)
train3 = Train.new(3, 'пассажиркий', 15)

# Может набирать скорость
train1.speed_up(30)

# Может возвращать текущую скорость
raise 'set speed error!' unless train1.speed == 30

# Может тормозить (сбрасывать скорость до нуля)
train1.speed_down
raise 'down speed error!' unless train1.speed == 0

# Может возвращать количество вагонов
raise 'get carriage count error!' unless train1.carriage_count == 10

# Может прицеплять/отцеплять вагоны (по одному вагону за операцию,
# метод просто увеличивает или уменьшает количество вагонов).
# Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
train1.add_carriage
raise 'add carriage error!' if train1.carriage_count != 11

train1.speed_up(20)

begin
  train1.add_carriage
rescue => e
  puts e
end

# Может принимать маршрут следования (объект класса Route)
route1 = Route.new(st1, st5)
train1.route = route1

# При назначении маршрута поезду, поезд автоматически помещается
# на первую станцию в маршруте.
raise 'set route error!' unless train1.current_station == st1

route1.add_transitional_station(st2)
route1.add_transitional_station(st3)
route1.add_transitional_station(st4)

# Может перемещаться между станциями, указанными в маршруте.
# Перемещение возможно вперед и назад, но только на 1 станцию за раз.
train1.go_to_next_station
raise 'go to next station error!' unless train1.current_station == st2
raise 'station trains list error' unless st2.list_trains.include?(train1)

train1.go_to_previous_station
raise 'go to prev station error!' unless train1.current_station == st1

# Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
raise 'next station error!' unless train1.next_station == st2

train1.go_to_next_station #current st 2
train1.go_to_next_station #current st 3

raise 'prev station error!' unless train1.previous_station == st2

true
