class CargoTrain < Train
  attr_reader :type

  @instances_count = 0

  def initialize(number, type = :cargo)
    super(number)
    @type = type
    validate_type!
  end

  def valid_type?
    validate!
    true
  rescue
    false
  end

  protected

  def validate_type!
    raise "Неверный тип поезда" if self.type != :cargo
  end

end
