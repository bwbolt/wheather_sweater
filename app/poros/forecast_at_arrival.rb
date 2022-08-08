class ForecastAtArrival
  attr_reader :conditions, :temperature

  def initialize(data, hours_to_destination)
    @temperature = set_temp(data, hours_to_destination)
    @conditions = set_conditions(data, hours_to_destination)
  end

  def set_temp(data, hours_to_destination)
    if hours_to_destination > 48
      data[:daily][(hours_to_destination / 24).to_i][:temp][:day]
    else
      data[:hourly][hours_to_destination][:temp]
    end
  end

  def set_conditions(data, hours_to_destination)
    if hours_to_destination > 48
      data[:daily][(hours_to_destination / 24).to_i][:weather][0][:description]
    else
      data[:hourly][hours_to_destination][:weather][0][:description]
    end
  end
end
