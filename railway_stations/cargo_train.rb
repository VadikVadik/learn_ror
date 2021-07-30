class CargoTrain < Train
  attr_reader :type

  @instances_count = 0

  def initialize(number, type = :cargo)
    super(number)
    @type = type
  end

end
