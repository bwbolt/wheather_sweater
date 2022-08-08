class RoadTrip
  def initialize(origin, destination)
    @start_city = origin
    @end_city = destination
    @travel_time = MapquestFacade.get_travel_time(origin, destination)
    @weather_at_eta =
  end
end
