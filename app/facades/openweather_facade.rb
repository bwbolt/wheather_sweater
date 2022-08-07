class OpenweatherFacade
  def self.create_forcast(location)
    parsed_json = OpenweatherService.get_forcast(location)
  end
end
