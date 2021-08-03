def menu
  puts "1. Создать станцию
2. Создать поезд
3. Добавить вагон поезду
4. Отцепить вагон от поезда
5. Просмотреть список вагонов поезда
6. Занять место/объем в вагоне
7. Создать маршрут
8. Редактировать маршрут
9. Назначить маршрут поезду
10. Перемещать поезд по маршруту
11. Просмотреть список станций
12. Просмотреть список поездов на станции
0. Выход"
end

def choose_train
  puts "Введите номер поезда"
  train_number = gets.chomp.to_sym
  while !@trains.has_key?(train_number) do
    puts "Такого поезда не существует, введите корректный номер поезда."
    train_number = gets.chomp.to_sym
  end
  train = @trains[train_number]
  return train
end

def choose_wagon
  train = choose_train
  puts "Введите номер вагона"
  wagon_number = gets.chomp.to_i
  wagon = train.wagons.select { |wagon| wagon.number == wagon_number}
  while wagon.empty? do
    puts "У поезда №#{train.number} нет вагона №#{wagon_number}, введите корректный номер вагона."
    wagon_number = gets.chomp.to_i
    wagon = train.wagons.select { |wagon| wagon.number == wagon_number}
  end
  return wagon[0]
end

def choose_station
  puts "Введите название станции"
  user_station = gets.chomp.to_sym
  while !@stations.has_key?(user_station) do
    puts "Такой станции не существует, введите корректное название станции."
    user_station = gets.chomp.to_sym
  end
  station = @stations[user_station]
  return station
end

def choose_route
  puts "Введите номер маршрута"
  route_number = gets.chomp.to_sym
  while !@routes.has_key?(route_number) do
    puts "Такого маршрута не существует, введите корректный номер маршрута."
    route_number = gets.chomp.to_sym
  end
  route = @routes[route_number]
  return route
end

def create_station
  puts "Введите название станции"
  station_title = gets.chomp
  @stations[station_title.to_sym] = Station.new(station_title)
  puts "***Станция #{station_title} создана***"
end

def create_train
  puts "Выберите тип поезда:
1. Пассажирский
2. Грузовой"
  user_input = gets.chomp.to_i
  puts "Введите номер поезда"
begin
  train_number = gets.chomp
  @trains[train_number.to_sym] = PassengerTrain.new(train_number) if user_input == 1
  @trains[train_number.to_sym] = CargoTrain.new(train_number) if user_input == 2
rescue StandardError => e
  puts e.message
  puts "***Введите номер поезда снова***"
  retry
end
  puts "***Поезд №#{train_number.to_s} создан***"
end

def add_next_wagon
  train = choose_train
  if train.type == :passenger
    puts "Введите количество мест в вагоне"
    begin
      seats = gets.chomp.to_i
      train.add_wagon(PassengerWagon.new(seats))
    rescue StandardError => e
      puts e.message
      puts "***Введите корректное количество мест***"
      retry
    end
  elsif train.type == :cargo
    puts "Введите объем вагона"
    begin
      volume = gets.chomp.to_i
      train.add_wagon(CargoWagon.new(volume))
    rescue StandardError => e
      puts e.message
      puts "***Введите корректный объем вагона***"
      retry
    end
  end
  train.wagons[-1].number = train.wagons.size
  puts "***Поезду №#{train.number} прицеплен вагон. Всего #{train.wagons.length} вагонов***"
end

def remove_last_wagon
  train = choose_train
  wagon = train.wagons[-1]
  train.remove_wagon(wagon)
  puts "***От поезда №#{train.number} отцеплен вагон. Всего #{train.wagons.length} вагонов***"
end

def create_route
  puts "Введите номер маршрута"
  route_number = gets.chomp.to_sym
  while @routes.has_key?(route_number) do
    puts "Такой маршрут уже существует, введите новый номер маршрута."
    route_number = gets.chomp.to_sym
  end
  puts "***СТАНЦИЯ ОТПРАВЛЕНИЯ***"
  departure_station = choose_station
  puts "***СТАНЦИЯ НАЗНАЧЕНИЯ***"
  arrival_station = choose_station
  @routes[route_number] = Route.new(departure_station, arrival_station)
  puts "***Маршрут №#{route_number.to_s} создан. Станция отправления:#{departure_station.title}, станция назначения:#{arrival_station.title}.***"
end

def edit_route
  route = choose_route
  puts "1. Добавить станцию
2. Удалить стацию"
  user_input = gets.chomp.to_i
  station = choose_station
  if user_input == 1
    route.add_transition_station(station)
    puts "***Станция #{station.title} добавлена в маршрут №#{@routes.key(route)}.***"
  elsif user_input == 2
    route.delete_transition_station(station)
    puts "***Станция #{station.title} удалена из маршрута №#{@routes.key(route)}.***"
  end
end

def assign_route
  train = choose_train
  route = choose_route
  train.destination_route(route)
  puts "***Маршрут №#{@routes.key(route)} назначен поезду №#{train.number}.***"
end

def move_train
  train = choose_train
  puts "Поезду №#{train.number} не назначен маршрут." if train.route == nil
  puts "1. Ехать вперед
2. Ехать назад"
  user_input = gets.chomp.to_i
  train.go_ahead if user_input == 1
  train.go_back if user_input == 2
  puts "***Поезд №#{train.number} прибыл на станцию #{train.current_station.title}.***"
end

def list_stations
  count = 1
  puts "Доступные станции:"
  @stations.each_value do |value|
    puts "#{count}. #{value.title}"
    count += 1
  end
end

def trains_at_station
  station = choose_station
  station.each_trains { |train| puts "Поезд №#{train.number}, тип: #{train.type.to_s}, количество вагонов: #{train.wagons.size}"}
end

def train_wagons_list
  train = choose_train
  train.each_wagons { |wagon| puts "Вагон №#{wagon.number}, тип: пассажирский, свободно мест: #{wagon.free_seats}, занято мест: #{wagon.occupied_seats}"} if train.type == :passenger
  train.each_wagons { |wagon| puts "Вагон №#{wagon.number}, тип: грузовой, свободный объем: #{wagon.free_volume}, использованный объем: #{wagon.used_volume}"} if train.type == :cargo
end

def take_the_wagon
  wagon = choose_wagon
  if wagon.type == :passenger
    puts "Сколько мест Вы хотите занять?"
    user_input = gets.chomp.to_i
    user_input.times {wagon.take_the_seat}
  elsif wagon.type == :cargo
    puts "Какой объем Вы хотите занять?"
    user_input = gets.chomp.to_i
    wagon.take_the_volume(user_input)
  end
end
