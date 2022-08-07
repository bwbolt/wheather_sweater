class MapquestFacade
  def self.get_coord(location)
    parsed_json = MapquestService.get_coord(location)

    Location.new(parsed_json)
  end
end
