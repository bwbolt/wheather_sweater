class OpenweatherFacade
  def self.create_forecast(location)
    parsed_json = OpenweatherService.get_forecast(location)

    Forecast.create_forecast(parsed_json)
  end

  def self.create_forecast_at_arrival(location, hours_to_destination)
    parsed_json = OpenweatherService.get_forecast(location)

    ForecastAtArrival.new(parsed_json, hours_to_destination)
  end

  def self.create_weather_at_eta(destination, travel_time)
    if travel_time == 'impossible route'
      nil
    else
      location = MapquestFacade.get_coord(destination)
      hours_to_destination = travel_time.split(':').first.to_i
      OpenweatherFacade.create_forecast_at_arrival(location, hours_to_destination)
    end
  end
end
