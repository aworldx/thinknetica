require 'byebug'
require './transport/train'
require './transport/carriage'
require './transport/station'
require './transport/cargo_train'

# Создать модуль, который позволит указывать название компании-производителя и
# получать его. Подключить модуль к классам Вагон и Поезд

jhonson_train = Transport::Train.new('111')
jhonson_train.manufacturer_name = 'Jhonson'

raise 'manufacturer module error' unless jhonson_train.manufacturer_name == 'Jhonson'

bg_carriage = Transport::Carriage.new('222')
bg_carriage.manufacturer_name = 'BG'

raise 'manufacturer module error' unless bg_carriage.manufacturer_name == 'BG'

# В классе Station (жд станция) создать метод класса all, который возвращает все
# станции (объекты), созданные на данный момент

st1 = Transport::Station.new('st1')
st2 = Transport::Station.new('st2')
st3 = Transport::Station.new('st3')
st4 = Transport::Station.new('st4')

stations = Transport::Station.all

raise 'Station.all error' unless stations.size == 4
raise 'Station.all error' unless stations.find { |st| st.name == 'st3' }

# Добавить к поезду атрибут Номер (произвольная строка), если его еще нет,
# который указыватеся при его создании

raise 'train number error' unless jhonson_train.number == '111'

# В классе Train создать метод класса find, который принимает номер поезда
# (указанный при его создании) и возвращает объект поезда по номеру или nil,
# если поезд с таким номером не найден.

Transport::Train.new('xxx')

raise 'Station.all error' unless Transport::Train.find('111')
raise 'Station.all error' unless Transport::Train.find('xxx')
raise 'Station.all error' unless Transport::Train.find('yyy').nil?

# Создать модуль InstanceCounter, содержащий следующие методы класса и
# инстанс-методы, которые подключаются автоматически при вызове include в классе:
#   Методы класса:
#     - instances, который возвращает кол-во экземпляров данного класса
#   Инастанс-методы:
#     - register_instance, который увеличивает счетчик кол-ва экземпляров класса
#       и который можно вызвать из конструктора. При этом данный метод не должен
#       быть публичным.
# Подключить этот модуль в классы поезда, маршрута и станции.
# Примечание: инстансы подклассов могут считатья по отдельности, не увеличивая
# счетчик инстансев базового класса.

raise 'Train.instances error' unless Transport::Train.instances == 2
raise 'Station.instances error' unless Transport::Station.instances == 4

if jhonson_train.public_methods.include?(:register_instance)
  raise 'train.register_instance error'
end

raise 'CargoTrain.instances error' unless Transport::CargoTrain.instances.zero?

Transport::CargoTrain.new('ccc')
raise 'CargoTrain.instances error' unless Transport::CargoTrain.instances == 1

p 'done'