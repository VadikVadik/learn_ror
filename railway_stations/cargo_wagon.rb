class CargoWagon
  include CompanyManufacturer
  attr_reader :type

  def initialize(type = :cargo)
    @type = type
  end

end
