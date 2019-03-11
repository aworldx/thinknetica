require 'byebug'
require './terminal/text_commandor'
require './terminal/base_command'
require './terminal/create_command'
require './terminal/call_command'
require './terminal/list_command'
require './terminal/custom_command'
require './terminal/transport_storage'
require './transport/train'
require './transport/cargo_train'
require './transport/passenger_train'
require './transport/carriage'
require './transport/cargo_carriage'
require './transport/passenger_carriage'
require './transport/station'
require './transport/route'
require 'date'

tr = Transport::Train.new(number: '123-11')

# accessors

tr.number = '456-77'
tr.driver = 'J. Nickolson'

p tr.number_history
p tr.driver_history

tr.number = '999-99'
tr.driver = 'K. Dronov'

p tr.number_history
p tr.driver_history

begin
  tr.manufacture_date = 123
rescue RuntimeError => e
  p e.message
end

tr.manufacture_date = Date.new(2019, 1, 1)
p tr.manufacture_date

# validators

raise 'validator error' unless tr.valid?

tr.number = '123'

raise 'validator error' if tr.valid?

begin
  p tr.validate!
rescue RuntimeError => e
  p e.message # "wrong format for attribute number"
end

tr.number = nil

raise 'validator error' if tr.valid?

begin
  p tr.validate!
rescue RuntimeError => e
  p e.message # "attribute number must be presented"
end

tr.number = '123-11'.to_sym

raise 'validator error' if tr.valid?

begin
  p tr.validate!
rescue RuntimeError => e
  p e.message # "wrong type for attribute number"
end

st = Transport::Station.new(name: nil)
raise 'validator error' if st.valid?

p tr.class.validations
p st.class.validations
