class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(origin, destination)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = MapquestFacade.get_travel_time(origin, destination)
    @weather_at_eta = OpenweatherFacade.create_weather_at_eta(destination, @travel_time)
  end
end
