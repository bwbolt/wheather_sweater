class Munchie
  attr_reader :id, :destination_city, :forecast, :resturant

  def initialize(term, location)
    @id = nil
    @destination_city = location
    @forecast = current_forecast(location)
    @resturant = YelpFacade.create_resturant(term, location)
  end

  def current_forecast(location)
    coord = MapquestFacade.get_coord(location)
    forecast = OpenweatherFacade.create_forecast(coord)
    ResturantCurrentWeather.new(forecast.current_weather)
  end
end
