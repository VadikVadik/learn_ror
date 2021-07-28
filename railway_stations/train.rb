class Train
  attr_accessor :number, :wagons, :current_speed, :current_station, :next_station, :previous_station, :route

  def initialize(number)
    @number = number
    @wagons = []
    @current_speed = 0
    @current_station
    @next_station
    @previous_station
    @route
  end

  def stop
    @current_speed = 0
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

  def destination_route(route)
    @route = route
    route.departure_station.take_train(self)
    @current_station = route.current_station(self)
    @next_station = route.next_station(self)
    @previous_station = "Train at the departure station"
  end

  def go_ahead
    if @current_station != @route.arrival_station
      @current_station.send_train(self)
      @next_station.take_train(self)
      @current_station = @route.current_station(self)
      @next_station = @route.next_station(self)
      @previous_station = @route.pre_station(self)
    else
      puts "Train at the end station."
      @next_station = "Train at the end station."
      @previous_station = @route.pre_station(self)
    end
  end

  def go_back
    if @current_station != @route.departure_station
      @current_station.send_train(self)
      @previous_station.take_train(self)
      @current_station = @route.current_station(self)
      @next_station = @route.next_station(self)
      @previous_station = @route.pre_station(self)
    else
      puts "Train at the departure station."
      @next_station = @route.next_station(self)
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

  protected #Методы помещены в protected в целях соблюдения принципа инкапсуляции, и соблюдения требований ТЗ о том, что вагоны могут прицпляться/отцепляться только когда поезд стоит на месте

  def add_wagon!(wagon)
    @wagons << wagon if self.type == wagon.type
  end

  def remove_wagon!(wagon)
    @wagons.delete(wagon) if self.type == wagon.type
  end
end
