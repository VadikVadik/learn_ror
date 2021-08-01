require_relative "instance_counter.rb"
require_relative "company_manufacturer.rb"
require_relative "station.rb"
require_relative "train.rb"
require_relative "passenger_train.rb"
require_relative "cargo_train.rb"
require_relative "passenger_wagon.rb"
require_relative "cargo_wagon.rb"
require_relative "route.rb"
require_relative "methods.rb"

@stations = {}
@trains = {}
@routes = {}

METHODS = {
  1 => :create_station,
  2 => :create_train,
  3 => :add_next_wagon,
  4 => :remove_last_wagon,
  5 => :create_route,
  6 => :edit_route,
  7 => :assign_route,
  8 => :move_train,
  9 => :list_stations,
  10 => :trains_at_station
}

loop do
  menu
  user_input = gets.chomp.to_i
  break if user_input == 0
  send(METHODS[user_input])
end
