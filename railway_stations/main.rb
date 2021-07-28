require_relative "station.rb"
require_relative "train.rb"
require_relative "passenger_train.rb"
require_relative "cargo_train.rb"
require_relative "passenger_wagon.rb"
require_relative "cargo_wagon.rb"
require_relative "route.rb"

stations = {}
trains = {}
routes = {}

loop do
  puts "1. Создать станцию
  2. Создать поезд
  3. Добавить вагон поезду
  4. Отцепить вагон от поезда
  5. Создать маршрут
  6. Редактировать маршрут
  7. Назначить маршрут поезду
  8. Перемещать поезд по маршруту
  9. Просмотреть список станций
  10. Просмотреть список поездов на станции
  0. Выход"

  user_input = gets.chomp
  break if user_input == "0"

  if user_input.to_i == 1
    puts "Введите название станции"
    station_title = gets.chomp
    stations[station_title.to_sym] = Station.new(station_title)
    puts "***Станция #{station_title} создана***"
  end

  if user_input.to_i == 2
    puts "Выберите тип поезда:
    1. Пассажирский
    2. Грузовой"
    user_input = gets.chomp
    puts "Введите номер поезда"
    train_number = gets.chomp

    if user_input == "1"
      trains[train_number.to_sym] = PassengerTrain.new(train_number)
      puts "***Пассажирский поезд №#{train_number} создан***"
    elsif user_input == "2"
      trains[train_number.to_sym] = CargoTrain.new(train_number)
      puts "***Грузовой поезд №#{train_number} создан***"
    end
  end

  if user_input.to_i == 3
    puts "Введите номер поезда"
    train_number = gets.chomp

    while !trains.has_key?(train_number.to_sym) do
      puts "Такого поезда не существует, введите корректный номер поезда."
      train_number = gets.chomp
    end

    train = trains[train_number.to_sym]

    if train.type == "passenger"
      train.add_wagon(PassengerWagon.new)
      puts "***Поезду №#{train.number} прицеплен вагон. Всего #{train.wagons.length} вагонов***"
    elsif train.type == "cargo"
      train.add_wagon(CargoWagon.new)
      "***Поезду №#{train.number} прицеплен вагон. Всего #{train.wagons.length} вагонов***"
    end
  end

  if user_input.to_i == 4
    puts "Введите номер поезда"
    train_number = gets.chomp

    while !trains.has_key?(train_number.to_sym) do
      puts "Такого поезда не существует, введите корректный номер поезда."
      train_number = gets.chomp
    end

    train = trains[train_number.to_sym]
    wagon = train.wagons[-1]

    if train.type == "passenger"
      train.remove_wagon(wagon)
      puts "***От поезда №#{train.number} отцеплен вагон. Всего #{train.wagons.length} вагонов***"
    elsif train.type == "cargo"
      train.remove_wagon(wagon)
      puts "***От поезда №#{train.number} отцеплен вагон. Всего #{train.wagons.length} вагонов***"
    end
  end

  if user_input.to_i == 5
    puts "Введите номер маршрута"
    route_number = gets.chomp

    while routes.has_key?(route_number.to_sym) do
      puts "Такой маршрут уже существует, введите новый номер маршрута."
      route_number = gets.chomp
    end

    puts "Введите название станции отправления"
    user_departure_station = gets.chomp

    while !stations.has_key?(user_departure_station.to_sym) do
      puts "Такой станции не существует, введите корректное название станции."
      user_departure_station = gets.chomp
    end

    departure_station = stations[user_departure_station.to_sym]

    puts "Введите название станции назначения"
    user_arrival_station = gets.chomp

    while !stations.has_key?(user_arrival_station.to_sym) do
      puts "Такой станции не существует, введите корректное название станции."
      user_arrival_station = gets.chomp
    end

    arrival_station = stations[user_arrival_station.to_sym]
    routes[route_number.to_sym] = Route.new(departure_station, arrival_station)
    puts "***Маршрут №#{route_number} создан. Станция отправления:#{departure_station.title}, станция назначения:#{arrival_station.title}.***"
  end

  if user_input.to_i == 6
    puts "Введите номер маршрута"
    route_number = gets.chomp

    while !routes.has_key?(route_number.to_sym) do
      puts "Такого маршрута не существует, введите корректный номер маршрута."
      route_number = gets.chomp
    end

    route = routes[route_number.to_sym]

    puts "1. Добавить станцию
          2. Удалить стацию"
    user_input = gets.chomp

    puts "Введите название станции"
    user_station = gets.chomp

    while !stations.has_key?(user_station.to_sym) do
      puts "Такой станции не существует, введите корректное название станции."
      user_station = gets.chomp
    end

    station = stations[user_station.to_sym]

    if user_input == "1"
      route.add_transition_station(station)
      puts "***Станция #{station.title} добавлена в маршрут №#{route_number}.***"
    elsif user_input == "2"
      route.delete_transition_station(station)
      puts "***Станция #{station.title} удалена из маршрута №#{route_number}.***"
    end
  end

  if user_input.to_i == 7
    puts "Введите номер поезда"
    train_number = gets.chomp

    while !trains.has_key?(train_number.to_sym) do
      puts "Такого поезда не существует, введите корректный номер поезда."
      train_number = gets.chomp
    end

    train = trains[train_number.to_sym]

    puts "Введите номер маршрута"
    route_number = gets.chomp

    while !routes.has_key?(route_number.to_sym) do
      puts "Такого маршрута не существует, введите корректный номер маршрута."
      route_number = gets.chomp
    end

    route = routes[route_number.to_sym]

    train.destination_route(route)
    puts "***Маршрут №#{route_number} назначен поезду №#{train_number}.***"
  end

  if user_input.to_i == 8
    puts "Введите номер поезда"
    train_number = gets.chomp

    while !trains.has_key?(train_number.to_sym) do
      puts "Такого поезда не существует, введите корректный номер поезда."
      train_number = gets.chomp
    end

    train = trains[train_number.to_sym]

    if train.route == nil
      puts "Поезду №#{train_number} не назначен маршрут."
    else
      puts "1. Ехать вперед
            2. Ехать назад"
      user_input = gets.chomp

      if user_input == "1"
        train.go_ahead
        puts "***Поезд №#{train_number} прибыл на станцию #{train.current_station}.***"
      elsif user_input == "2"
        train.go_back
        puts "***Поезд №#{train_number} прибыл на станцию #{train.current_station}.***"
      end
    end
  end

  if user_input.to_i == 9
    count = 1
    puts "Доступные станции:"
    stations.each do |key, value|
      puts "#{count}. #{value.title}"
      count += 1
    end
  end

  if user_input.to_i == 10
    puts "Введите название станции"
    user_station = gets.chomp

    while !stations.has_key?(user_station.to_sym) do
      puts "Такой станции не существует, введите корректное название станции."
      user_station = gets.chomp
    end

    station = stations[user_station.to_sym]

    puts "1. Все поезда
    2. Пассажирские поезда
    3. Грузовые поезда"

    user_type = gets.chomp

    if user_type == "1"
      puts "Все поезда на станции #{station.title}:"
      station.trains_list("all")
    elsif user_type == "2"
      puts "Пассажирские поезда на станции #{station.title}:"
      station.trains_list("passenger")
    elsif user_type == "3"
      puts "Грузовые поезда на станции #{station.title}:"
      station.trains_list("cargo")
    end
  end
end
