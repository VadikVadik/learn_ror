class PassengerWagon
  include CompanyManufacturer
  attr_reader :type

  def initialize(type = :passenger)
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
    raise "Неверный тип вагона" if @type != :passenger
  end

end
