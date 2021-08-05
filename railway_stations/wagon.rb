class Wagon
  include InstanceCounter
  include CompanyManufacturer
  attr_accessor :free_place, :used_place, :number
  attr_reader :type, :place
  @instances_count = 0

  def initialize(type = self.class::TYPE, place)
    @type = type
    @place = place
    @used_place = 0
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def free_place
    place - used_place
  end

  def type_to_s
    return "Пассажирский" if self.class::TYPE == :passenger
    return "Грузовой" if self.class::TYPE == :cargo
  end

  protected

  def validate!
    errors = []
    errors << "Нет данных о количестве мест в вагоне" if place.nil?
    errors << "Неверное количество мест в вагоне" if place == 0
    raise errors.join(". ") unless errors.empty?
  end
end
