class MapquestFacade
  def self.get_coord(location)
    parsed_json = MapquestService.get_coord(location)

    Location.new(parsed_json)
  end

  def self.get_travel_time(origin, destination)
    parsed_json = MapquestService.get_travel_time(origin, destination)
    if parsed_json[:info][:messages].include?('We are unable to route with the given locations.')
      'impossible route'
    else
      parsed_json[:route][:formattedTime]
    end
  end
end
