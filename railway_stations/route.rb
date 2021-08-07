# frozen_string_literal: true

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
  rescue StandardError
    false
  end

  def add_transition_station(station)
    stations_list.insert(-2, station)
  end

  def delete_transition_station(station)
    stations_list.delete(station) if stations_list.include?(station)
  end

  def current_station(train)
    stations_list.each do |station|
      return station if station.trains.include?(train)
    end
  end

  def next_station(train)
    current = current_station(train)
    index = stations_list.index(current)
    stations_list[index + 1]
  end

  def pre_station(train)
    current = current_station(train)
    index = stations_list.index(current)
    stations_list[index - 1]
  end

  def go_ahead(train)
    if train.current_station != arrival_station
      train.current_station.send_train(train)
      train.next_station.take_train(train)
      train.current_station = current_station(train)
      train.next_station = next_station(train)
    else
      train.next_station = "Train at the end station."
    end
    train.previous_station = pre_station(train)
  end

  def go_back(train)
    if train.current_station != departure_station
      train.current_station.send_train(train)
      train.previous_station.take_train(train)
      train.current_station = current_station(train)
      train.next_station = next_station(train)
      train.previous_station = pre_station(train)
    else
      train.next_station = next_station(train)
      train.previous_station = "Train at the departure station"
    end
  end

  def print_stations_list
    stations_list.each_with_index { |station, index| puts "#{index + 1}. #{station.title}" }
  end

  protected

  def validate!
    errors = []
    errors << "Отсутствуют сведения о станции отправления" if departure_station.nil?
    errors << "Отсутствуют сведения о станции назначения" if arrival_station.nil?
    raise errors.join(". ") unless errors.empty?
  end
end
