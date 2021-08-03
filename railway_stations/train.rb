class Train
  include InstanceCounter
  include CompanyManufacturer

  attr_accessor :number, :wagons, :current_speed, :instances_count, :current_station, :next_station, :previous_station, :route
  TRAIN_NUMBER_FORMAT = /^[A-Z0-9]{3}-?[A-Z0-9]{2}$/i
  @@all_trains = []
  @instances_count = 0

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @current_speed = 0
    @@all_trains << self
    register_instance
  end

  def self.find(number)
    @@all_trains.select { |train| train.number == number}.first
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def stop
    self.current_speed = 0
  end

  def stoped?
    @current_speed.zero?
  end

  def add_wagon(wagon)
    self.add_wagon!(wagon) if self.stoped?
  end

  def remove_wagon(wagon)
    self.remove_wagon!(wagon) if self.stoped?
  end

  def each_wagons
    self.wagons.each { |wagon| yield(wagon) }
  end

  def destination_route(route)
    @route = route
    route.departure_station.take_train(self)
    @current_station = route.current_station(self)
    @next_station = route.next_station(self)
    @previous_station = "Train at the departure station"
  end

  def go_ahead
    self.route.go_ahead(self)
  end

  def go_back
    self.route.go_back(self)
  end

  protected

  def validate!
    errors = []
    errors << "У поезда должен быть номер" if self.number.nil?
    errors << "Номер поезда должен содержать не менее 5 символов" if self.number.size < 5
    errors << "Неверный формат номера поезда" if self.number !~ TRAIN_NUMBER_FORMAT
    raise errors.join(". ") unless errors.empty?
  end

  def add_wagon!(wagon)
    @wagons << wagon if self.type == wagon.type
  end

  def remove_wagon!(wagon)
    @wagons.delete(wagon) if self.type == wagon.type
  end
end
