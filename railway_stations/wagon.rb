# frozen_string_literal: true

class Wagon
  include Validation
  include Accessors
  include InstanceCounter
  include CompanyManufacturer

  TYPE = "No type"

  attr_accessor :number
  attr_accessor_with_history :used_place
  attr_writer :free_place
  attr_reader :type, :place

  validate :place, :presence

  @instances_count = 0

  def initialize(place, type = self.class::TYPE)
    @type = type
    @place = place
    @used_place = 0
    validate!
    register_instance
  end

  def free_place
    place - used_place
  end

  def type_to_s
    return "Пассажирский" if self.class::TYPE == :passenger
    return "Грузовой" if self.class::TYPE == :cargo
  end
end
