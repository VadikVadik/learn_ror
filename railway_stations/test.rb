require_relative "instance_counter.rb"
require_relative "company_manufacturer.rb"
require_relative "station.rb"
require_relative "train.rb"
require_relative "passenger_train.rb"
require_relative "cargo_train.rb"
require_relative "wagon.rb"
require_relative "passenger_wagon.rb"
require_relative "cargo_wagon.rb"
require_relative "route.rb"
require_relative "methods.rb"

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

Station.all.each { |station| puts "Станция #{station.title} создана."; sleep 0.2}
separator
puts "***СОЗДАЮ ПОЕЗДА***"
separator
sleep 0.3

train_1 = PassengerTrain.new("007-AA")
train_2 = CargoTrain.new("777-00")

Train.all.each { |train| puts "Создан поезд №#{train.number}, тип: #{train.type_to_s}."; sleep 0.2}

separator
puts "***ПРИЦЕПЛЯЮ ВАГОНЫ***"
separator
sleep 0.3

5.times {train_1.add_wagon(PassengerWagon.new)}
5.times {train_2.add_wagon(CargoWagon.new)}

Train.all.each do |train|
  puts "К поезду №#{train.number} прицеплено #{train.wagons.size} вагонов:"
  train.each_wagons { |wagon| puts "Вагон №#{wagon.number}, свободно #{wagon.free_place} #{wagon.class::UNIT}, занято #{wagon.used_place} #{wagon.class::UNIT}."; sleep 0.2}
  sleep 0.3
end

separator
puts "***СОЗДАЮ МАРШРУТЫ***"
separator
sleep 0.3
routes = []

route_1 = Route.new(moskow, ptz)
routes << route_1

route_2 = Route.new(svir, adler)
routes << route_2

routes.each { |route| puts "Создан маршрут: #{route.departure_station.title} - #{route.arrival_station.title}."; sleep 0.2}

separator
puts "***ДОБАВЛЯЮ СТАНЦИИ В МАРШРУТЫ***"
separator
sleep 0.3

route_1.add_transition_station(tver)
route_1.add_transition_station(spb)
route_1.add_transition_station(lp)

puts "Маршрут: #{route_1.departure_station.title} - #{route_1.arrival_station.title}:"
route_1.print_stations_list
sleep 0.2

route_2.add_transition_station(rzn)
route_2.add_transition_station(rostov)
route_2.add_transition_station(krasnodar)

puts "Маршрут: #{route_2.departure_station.title} - #{route_2.arrival_station.title}:"
route_2.print_stations_list

separator
puts "***НАЗНАЧАЮ ПОЕЗДА НА МАРШРУТЫ***"
separator
sleep 0.3

train_1.destination_route(route_1)
train_2.destination_route(route_2)

Train.all.each { |train| puts "Поезд №#{train.number} назначен на маршрут #{train.route.departure_station.title} - #{train.route.arrival_station.title}."; sleep 0.2}

separator
puts "***ПРОДАЮ МЕСТА В ПОЕЗДАХ***"
separator
sleep 0.3

puts "ПОЕЗД №#{train_1.number}"
sleep 0.2

train_1.each_wagons do |wagon|
  rand(51).times {wagon.take_place}
  puts "В вагоне №#{wagon.number} поезда №#{train_1.number} продано #{wagon.used_place} #{wagon.class::UNIT}, свободно #{wagon.free_place} #{wagon.class::UNIT}."
  sleep 0.2
end

puts "ПОЕЗД №#{train_2.number}"
sleep 0.2

train_2.each_wagons do |wagon|
  wagon.take_place(rand(501))
  puts "В вагоне №#{wagon.number} поезда №#{train_2.number} продано #{wagon.used_place} #{wagon.class::UNIT}, свободно #{wagon.free_place} #{wagon.class::UNIT}."
  sleep 0.2
end

separator
puts "***ОТПРАВЛЯЮ ПОЕЗДА***"
separator
sleep 0.3

Train.all.each do |train|
  puts "ПОЕЗД №#{train.number} отправляется со станции #{train.current_station.title}, следующая станиця #{train.next_station.title}"
  sleep 0.2
  train_1.go_ahead
  puts "ПОЕЗД №#{train.number} прибыл на станцию #{train.current_station.title}, следующая станиця #{train.next_station.title}"
  sleep 0.2
  train_1.go_ahead
  puts "ПОЕЗД №#{train.number} прибыл на станцию #{train.current_station.title}, следующая станиця #{train.next_station.title}"
  sleep 0.2
  train_1.go_ahead
  puts "ПОЕЗД №#{train.number} прибыл на станцию #{train.current_station.title}, следующая станиця #{train.next_station.title}"
  sleep 0.2
  train_1.go_ahead
  puts "ПОЕЗД №#{train.number} прибыл на конечную станцию #{train.current_station.title}"
  separator
  puts "На станции #{train.current_station.title} находятся следующие поезда:"
  train.current_station.each_trains { |train| puts "Поезд №#{train.number}, тип: #{train.type_to_s}, #{train.wagons.size} вагонов."}
  separator
end
