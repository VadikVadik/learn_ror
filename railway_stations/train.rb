class Train
  attr_accessor :current_speed
  attr_reader :number, :type, :wagons, :current_station, :next_station, :previous_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
    @current_station
    @next_station
    @previous_station
    @route
  end

  def stop
    @current_speed = 0
  end

  def add_remove_wagon(sign)
    if @current_speed == 0
      if sign == "+"
        @wagons += 1
      elsif sign == "-"
        @wagons -= 1
      end
    else
      puts "Stop the train!"
    end
  end

  def destination_route(route)
    @route = route
    route.departure_station.take_train(self)
    @current_station = route.departure_station
    @next_station = route.stations_list[1]
    @previous_station = "Train at the departure station"
  end

  def go_ahead
    if @current_station != @route.stations_list.last
      @current_station.send_train(self)
      index = @route.stations_list.index(@current_station)
      @current_station = @route.stations_list[index + 1]
      @current_station.take_train(self)
      @next_station = @route.stations_list[index + 2]
      @previous_station = @route.stations_list[index]
    else
      puts "Train at the end station."
      @next_station = "Train at the end station."
      @previous_station = @route.stations_list[-2]
    end
  end

  def go_back
    if @current_station != @route.stations_list.first
      @current_station.send_train(self)
      index = @route.stations_list.index(@current_station)
      @current_station = @route.stations_list[index - 1]
      @current_station.take_train(self)
      @next_station = @route.stations_list[index]
      @previous_station = @route.stations_list[index + 2]
    else
      puts "Train at the departure station."
      @next_station = route.stations_list[1]
      @previous_station = "Train at the departure station"
    end
  end

  def current_station
    @current_station.title
  end

  def next_station
    @next_station.title
  end

  def previous_station
    @previous_station.title
  end

end
