class Station
  include InstanceCounter

  attr_accessor :title, :trains

  @@all_stations = []
  @instances_count = 0

  def initialize(title)
    @title = title
    validate!
    @trains = []
    @@all_stations << self
    register_instance
  end

  def self.all
    @@all_stations
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def each_trains
    self.trains.each { |train| yield(train) }
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

  protected

  def validate!
    errors = []
    errors << "Название станции не введено" if self.title.nil?
    errors << "Название станции должно содержать не менее 1 символа" if self.title.size == 0
    raise errors.join(". ") unless errors.empty?
  end

end
