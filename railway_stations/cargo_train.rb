class CargoTrain < Train
  attr_reader :type

  def initialize(number, type = "cargo")
    super(number)
    @type = type
  end

end
