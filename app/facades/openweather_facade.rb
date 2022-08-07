class OpenweatherFacade
  def self.create_forcast(location)
    parsed_json = OpenweatherService.get_forcast(location)

    Forcast.create_forcast(parsed_json)
  end
end
