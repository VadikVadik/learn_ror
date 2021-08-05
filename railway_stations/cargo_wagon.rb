class CargoWagon < Wagon
  UNIT = "м3"
  TYPE = :cargo

  @instances_count = 0

  def initialize(place = 500)
    super
  end

  def take_place(amount)
    self.used_place += amount if self.free_place >= amount
  end

end
