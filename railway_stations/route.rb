class Route
  include InstanceCounter

  attr_reader :departure_station, :arrival_station, :stations_list
  @instances_count = 0

  def initialize(departure_station, arrival_station)
    @departure_station = departure_station
    @arrival_station = arrival_station
    validate!
    @stations_list = [departure_station, arrival_station]
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def add_transition_station(station)
    @stations_list.insert(-2, station)
  end

  def delete_transition_station(station)
    if @stations_list.include?(station)
      @stations_list.delete(station)
    end
  end

  def current_station(train)
    @stations_list.each do |station|
      if station.trains.include?(train)
        return station
      end
    end
  end

  def next_station(train)
    current = self.current_station(train)
    index = @stations_list.index(current)
    return @stations_list[index + 1]
  end

  def pre_station(train)
    current = self.current_station(train)
    index = @stations_list.index(current)
    return @stations_list[index - 1]
  end

  def go_ahead(train)
    if train.current_station != self.arrival_station
      train.current_station.send_train(train)
      train.next_station.take_train(train)
      train.current_station = self.current_station(train)
      train.next_station = self.next_station(train)
      train.previous_station = self.pre_station(train)
    else
      train.next_station = "Train at the end station."
      train.previous_station = self.pre_station(train)
    end
  end

  def go_back(train)
    if train.current_station != self.departure_station
      train.current_station.send_train(train)
      train.previous_station.take_train(train)
      train.current_station = self.current_station(train)
      train.next_station = self.next_station(train)
      train.previous_station = self.pre_station(train)
    else
      train.next_station = self.next_station(train)
      train.previous_station = "Train at the departure station"
    end
  end

  def print_stations_list
    @stations_list.each { |station| puts station.title }
  end

  protected

  def validate!
    raise "Отсутствуют сведения о станции отправления/назначения" if self.departure_station.nil? || self.arrival_station.nil?
    raise "Отсутствуют сведения о станции отправления/назначения" if self.departure_station.size == 0 || self.arrival_station.size == 0
  end

end
