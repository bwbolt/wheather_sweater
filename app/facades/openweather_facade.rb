class OpenweatherFacade
  def self.create_forecast(location)
    parsed_json = OpenweatherService.get_forecast(location)

    Forecast.create_forecast(parsed_json)
  end
end
