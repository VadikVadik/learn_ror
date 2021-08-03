class CargoWagon
  include CompanyManufacturer
  attr_accessor :free, :used, :number
  attr_reader :type, :volume

  def initialize(type = :cargo, volume)
    @type = type
    @volume = volume
    @free = volume
    @used = 0
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def take_the_volume(volume)
    if self.used_volume < self.volume
      @free -= volume
      @used += volume
    end
  end

  def used_volume
    self.used
  end

  def free_volume
    self.free
  end

  protected

  def validate!
    errors = []
    errors << "Неверный тип вагона" if self.type != :cargo
    errors << "Отсутствуют данные об объеме вагона" if self.volume.nil?
    errors << "Неверный объем вагона" if self.volume == 0
    raise errors.join(". ") unless errors.empty?
  end

end
