class PassengerTrain < Train
  attr_reader :type

  @instances_count = 0

  def initialize(number, type = :passenger)
    super(number)
    @type = type
  end

end
