class CargoWagon
  include CompanyManufacturer
  attr_reader :type

  def initialize(type = :cargo)
    @type = type
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise "Неверный тип вагона" if @type != :cargo
  end

end
