class PassengerWagon < Wagon
  UNIT = "мест"
  TYPE = :passenger

  @instances_count = 0

  def initialize(place = 50)
    super
  end

  def take_place
    self.used_place += 1 if self.free_place > 0
  end

end
