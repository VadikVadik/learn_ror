# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'company_manufacturer'
require_relative 'station'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'route'
require_relative 'methods'

def separator
  45.times do
    print '='
    sleep 0.015
  end
  puts
end

puts "***ПРОГРАММА УПРАВЛЕНИЯ ЖЕЛЕЗНОЙ ДОРОГОЙ***"
separator
sleep 0.3
puts "***СОЗДАЮ СТАНЦИИ***"
separator
sleep 0.3

moskow = Station.new("Москва")
spb = Station.new("Санкт-Петербург")
ptz = Station.new("Петрозаводск")
tver = Station.new("Тверь")
lp = Station.new("Лодейное Поле")
svir = Station.new("Свирь")
adler = Station.new("Адлер")
krasnodar = Station.new("Краснодар")
rostov = Station.new("Ростов на Дону")
rzn = Station.new("Рязань")

Station.all.each { |station| puts "Станция #{station.title} создана." }
separator
puts "***СОЗДАЮ ПОЕЗДА***"
separator
sleep 0.3

train_one = PassengerTrain.new("007-AA")
train_two = CargoTrain.new("777-00")

Train.all.each { |train| puts "Создан поезд №#{train.number}, тип: #{train.type_to_s}." }

separator
puts "***ПРИЦЕПЛЯЮ ВАГОНЫ***"
separator
sleep 0.3

5.times { train_one.add_wagon(PassengerWagon.new) }
5.times { train_two.add_wagon(CargoWagon.new) }

Train.all.each do |train|
  puts "К поезду №#{train.number} прицеплено #{train.wagons.size} вагонов:"
  train.each_wagons do |wagon|
    puts "Вагон №#{wagon.number}, свободно #{wagon.free_place} #{wagon.class::UNIT}," \
      " занято #{wagon.used_place} #{wagon.class::UNIT}."
    sleep 0.2
  end
  sleep 0.3
end

separator
puts "***СОЗДАЮ МАРШРУТЫ***"
separator
sleep 0.3
routes = []

route_one = Route.new(moskow, ptz)
routes << route_one

route_two = Route.new(svir, adler)
routes << route_two

routes.each do |route|
  puts "Создан маршрут: #{route.departure_station.title} - #{route.arrival_station.title}."
end

separator
puts "***ДОБАВЛЯЮ СТАНЦИИ В МАРШРУТЫ***"
separator
sleep 0.3

route_one.add_transition_station(tver)
route_one.add_transition_station(spb)
route_one.add_transition_station(lp)

puts "Маршрут: #{route_one.departure_station.title} - #{route_one.arrival_station.title}:"
route_one.print_stations_list
sleep 0.2

route_two.add_transition_station(rzn)
route_two.add_transition_station(rostov)
route_two.add_transition_station(krasnodar)

puts "Маршрут: #{route_two.departure_station.title} - #{route_two.arrival_station.title}:"
route_two.print_stations_list

separator
puts "***НАЗНАЧАЮ ПОЕЗДА НА МАРШРУТЫ***"
separator
sleep 0.3

train_one.destination_route(route_one)
train_two.destination_route(route_two)

Train.all.each do |train|
  puts "Поезд №#{train.number} назначен на маршрут #{train.route.departure_station.title}" \
    " - #{train.route.arrival_station.title}."
  sleep 0.2
end

separator
puts "***ПРОДАЮ МЕСТА В ПОЕЗДАХ***"
separator
sleep 0.3

puts "ПОЕЗД №#{train_one.number}"
sleep 0.2

train_one.each_wagons do |wagon|
  rand(51).times { wagon.take_place }
  puts "В вагоне №#{wagon.number} поезда №#{train_one.number} продано #{wagon.used_place} #{wagon.class::UNIT}," \
    " свободно #{wagon.free_place} #{wagon.class::UNIT}."
  sleep 0.2
end

puts "ПОЕЗД №#{train_two.number}"
sleep 0.2

train_two.each_wagons do |wagon|
  wagon.take_place(rand(501))
  puts "В вагоне №#{wagon.number} поезда №#{train_two.number} продано #{wagon.used_place} #{wagon.class::UNIT}," \
    " свободно #{wagon.free_place} #{wagon.class::UNIT}."
  sleep 0.2
end

separator
puts "***ОТПРАВЛЯЮ ПОЕЗДА***"
separator
sleep 0.3

Train.all.each do |train|
  puts "ПОЕЗД №#{train.number} отправляется со станции #{train.current_station.title}," \
    " следующая станиця #{train.next_station.title}"
  sleep 0.2
  train_one.go_ahead
  puts "ПОЕЗД №#{train.number} прибыл на станцию #{train.current_station.title}," \
    " следующая станиця #{train.next_station.title}"
  sleep 0.2
  train_one.go_ahead
  puts "ПОЕЗД №#{train.number} прибыл на станцию #{train.current_station.title}," \
    " следующая станиця #{train.next_station.title}"
  sleep 0.2
  train_one.go_ahead
  puts "ПОЕЗД №#{train.number} прибыл на станцию #{train.current_station.title}," \
    " следующая станиця #{train.next_station.title}"
  sleep 0.2
  train_one.go_ahead
  puts "ПОЕЗД №#{train.number} прибыл на конечную станцию #{train.current_station.title}"
  separator
  puts "На станции #{train.current_station.title} находятся следующие поезда:"
  train.current_station.each_trains do |t|
    puts "Поезд №#{t.number}, тип: #{t.type_to_s}, #{t.wagons.size} вагонов."
  end
  separator
end
