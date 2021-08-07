# frozen_string_literal: true

class Station
  include InstanceCounter

  attr_accessor :title, :trains

  @@stations = []
  @instances_count = 0

  def initialize(title)
    @title = title
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def each_trains(&block)
    trains.each(&block)
  end

  def take_train(train)
    trains << train
  end

  def send_train(train)
    @trains.delete(train) if @trains.include?(train)
  end

  def trains_list(train_type)
    puts "***На станции #{title} нет поездов.***" if trains.empty?

    trains = if train_type == :all
               self.trains
             else
               self.trains.select { |train| train.type == train_type }
             end

    trains.each_with_index do |train, index|
      puts "#{index + 1}. Поезд №#{train.number}"
    end
  end

  protected

  def validate!
    errors = []
    errors << "Название станции не введено" if title.nil?
    errors << "Название станции должно содержать не менее 1 символа" if title.size.zero?
    raise errors.join(". ") unless errors.empty?
  end
end
