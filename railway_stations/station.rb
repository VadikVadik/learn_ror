class Station
  attr_accessor :title, :trains

  def initialize(title)
    self.title = title
    self.trains = []
  end

  def take_train(train)
    self.trains << train
  end

  def send_train(train)
    if self.trains.include?(train)
      self.trains.delete(train)
    end
  end

  def trains_list(train_type)
    count = 1
    if self.trains.empty?
      puts "***На станции #{self.title} нет поездов.***"
      return
    end

    if train_type == "all"
      self.trains.each do |train|
        puts "#{count}. Поезд №#{train.number}"
        count += 1
      end
    elsif train_type == "passenger"
      self.trains.each do |train|
        if train.type == "passenger"
          puts "#{count}. Поезд №#{train.number}"
          count += 1
        end
      end
    elsif train_type == "cargo"
      self.trains.each do |train|
        if train.type == "cargo"
          puts "#{count}. Поезд №#{train.number}"
          count += 1
        end
      end
    end
  end
end

#Все методы public
