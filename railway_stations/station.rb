class Station
  attr_reader :title, :trains

  def initialize(title)
    @title = title
    @trains = []
  end

  def take_train(train)
    @trains << train
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    end
  end

  def trains_list(train_type)
    if train_type == "all"
      puts "Now at the station:"
      @trains.each { |train| puts "Train №#{train.number}, type: #{train.type}"}
    elsif train_type == "passenger"
      puts "Passenger trains at the station:"
      @trains.each { |train| puts "Train №#{train.number}, type: #{train.type}" if train.type == "passenger"}
    elsif train_type == "freight"
      puts "Freight trains at the station:"
      @trains.each { |train| puts "Train №#{train.number}, type: #{train.type}" if train.type == "freight"}
    end
  end

end
