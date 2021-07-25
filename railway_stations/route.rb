class Route

  attr_reader :departure_station, :arrival_station, :stations_list

  def initialize(departure_station, arrival_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    @stations_list = [departure_station, arrival_station]
  end

  def add_transition_station(station)
    @stations_list.insert(-2, station)
  end

  def delete_transition_station(station)
    if @stations_list.include?(station)
      @stations_list.delete(station)
    end
  end

  def print_stations_list
    @stations_list.each { |station| puts station.title }
  end

end
