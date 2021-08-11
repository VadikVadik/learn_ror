# frozen_string_literal: true

class Train
  include Validation
  include InstanceCounter
  include CompanyManufacturer

  TRAIN_NUMBER_FORMAT = /^[A-Z0-9]{3}-?[A-Z0-9]{2}$/i.freeze
  TYPE = "No type"

  attr_accessor :number, :wagons, :current_speed, :instances_count, :current_station, :next_station, :previous_station,
                :route
  attr_reader :type

  validate :number, :presence
  validate :number, :format, TRAIN_NUMBER_FORMAT

  @@trains = []
  @instances_count = 0

  def initialize(number, type = self.class::TYPE)
    @number = number
    @type = type
    validate!
    @wagons = []
    @current_speed = 0
    @@trains << self
    register_instance
  end

  def self.all
    @@trains
  end

  def self.find(number)
    @@trains.detect { |train| train.number == number }
  end

  def type_to_s
    return "Пассажирский" if self.class::TYPE == :passenger
    return "Грузовой" if self.class::TYPE == :cargo
  end

  def stop
    @current_speed = 0
  end

  def stoped?
    @current_speed.zero?
  end

  def add_wagon(wagon)
    add_wagon!(wagon) if stoped?
  end

  def remove_wagon(wagon)
    remove_wagon!(wagon) if stoped?
  end

  def each_wagons(&block)
    wagons.each(&block)
  end

  def destination_route(route)
    @route = route
    route.departure_station.take_train(self)
    @current_station = route.current_station(self)
    @next_station = route.next_station(self)
    @previous_station = "Train at the departure station"
  end

  def go_ahead
    route.go_ahead(self)
  end

  def go_back
    route.go_back(self)
  end

  protected

  def add_wagon!(wagon)
    return unless type == wagon.type

    wagons << wagon
    wagon.number = wagons.size
  end

  def remove_wagon!(wagon)
    wagons.delete(wagon) if type == wagon.type
  end
end
