class Station
  include InstanceCounter

  attr_accessor :title, :trains
  @@all_stations = []
  @instances_count = 0

  def initialize(title)
    @title = title
    @trains = []
    @@all_stations << self
    register_instance
  end

  def self.all
    @@all_stations
  end

  def take_train(train)
    self.trains << train
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    end
  end

  def trains_list(train_type)

    if self.trains.empty?
      puts "***На станции #{self.title} нет поездов.***"
      return
    end

    if train_type == :all
      trains = self.trains
    else
      trains = self.trains.select { |train| train.type == train_type}
    end

    trains.each_with_index do |train, index|
      puts "#{index + 1}. Поезд №#{train.number}"
    end
  end
end

#Все методы public
