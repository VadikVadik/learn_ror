class PassengerWagon
  include CompanyManufacturer
  attr_accessor :free, :occupied, :number
  attr_reader :type, :seats

  def initialize(type = :passenger, seats)
    @type = type
    @seats = seats
    @free = seats
    @occupied = 0
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def take_the_seat
    if self.occupied_seats < self.seats
      @free -= 1
      @occupied += 1
    end
  end

  def occupied_seats
    self.occupied
  end

  def free_seats
    self.free
  end

  protected

  def validate!
    errors = []
    errors << "Неверный тип вагона" if self.type != :passenger
    errors << "Нет данных о количестве мест в вагоне" if self.seats.nil?
    errors << "Неверное количество мест в вагоне" if self.seats == 0
    raise errors.join(". ") unless errors.empty?
  end

end
