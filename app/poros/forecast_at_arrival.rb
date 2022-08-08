class ForecastAtArrival
  def initialize(data, hours_to_destination)
    @temperature = data[:hourly][hours_to_destination][:temp]
    @conditions = data[:hourly][hours_to_destination][:weather][0][:description]
  end
end
