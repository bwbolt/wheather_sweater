class MapquestFacade
  def self.get_coord(location)
    parsed_json = MapquestService.get_coord(location)

    Location.new(parsed_json)
  end

  def self.get_travel_time(origin, destination)
    parsed_json = MapquestService.get_travel_time(origin, destination)
    minutes = parsed_json[:route][:realTime]

    if minutes.nil?
      'impossible route'
    else
      Time.at(minutes).utc.strftime('%H hours %M minutes')
    end
  end
end
