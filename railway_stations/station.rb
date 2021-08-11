# frozen_string_literal: true

class Station
  include Validation
  include Accessors
  include InstanceCounter

  attr_accessor :title
  strong_attr_accessor :trains, Array

  validate :title, :presence

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
end
