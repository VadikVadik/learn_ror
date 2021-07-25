class Station
  attr_reader :title, :trains, :passenger_trains, :freight_trains

  def initialize(title)
    @title = title
    @trains = []
    @passenger_trains = []
    @freight_trains = []
  end

  def take_train(train)
    @trains << train
    if train.type == "passenger"
      @passenger_trains << train
    elsif train.type == "freight"
      @freight_trains << train
    end
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
      if train.type == "passenger"
        @passenger_trains.delete(train)
      elsif train.type == "freight"
        @freight_trains.delete(train)
      end
    end
  end

  def trains_list(train_type)
    if train_type == "all"
      puts "Now at the station:"
      @trains.each { |train| puts "Train №#{train.number}, type: #{train.type}"}
    elsif train_type == "passenger"
      puts "Passenger trains at the station:"
      @passenger_trains.each { |train| puts "Train №#{train.number}, type: #{train.type}"}
    elsif train_type == "freight"
      puts "Freight trains at the station:"
      @freight_trains.each { |train| puts "Train №#{train.number}, type: #{train.type}"}
    end
  end

end
