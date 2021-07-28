class PassengerTrain < Train
  attr_reader :type

  def initialize(number, type = "passenger")
    super(number)
    @type = type
  end

end
