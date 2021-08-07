# frozen_string_literal: true

class PassengerWagon < Wagon
  UNIT = "мест"
  TYPE = :passenger

  @instances_count = 0

  def initialize(place = 50)
    super
  end

  def take_place
    self.used_place += 1 if free_place.positive?
  end
end
