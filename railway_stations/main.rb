# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'company_manufacturer'
require_relative 'validation'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'methods'

@stations = {}
@trains = {}
@routes = {}

METHODS = {
  1 => :create_station,
  2 => :create_train,
  3 => :add_next_wagon,
  4 => :remove_last_wagon,
  5 => :train_wagons_list,
  6 => :take_the_wagon,
  7 => :create_route,
  8 => :edit_route,
  9 => :assign_route,
  10 => :move_train,
  11 => :list_stations,
  12 => :trains_at_station
}.freeze

loop do
  menu
  user_input = gets.chomp.to_i
  break if user_input.zero?

  send(METHODS[user_input])
end
