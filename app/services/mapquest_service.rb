class MapquestService
  def self.get_coord(location)
    response = connection.get('/geocoding/v1/address') do |req|
      req.params['key'] = ENV['MAPQUEST_KEY']
      req.params['location'] = location
    end

    parsed_json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_travel_time(origin, destination)
    response = connection.get('/directions/v2/route') do |req|
      req.params['key'] = ENV['MAPQUEST_KEY']
      req.params['from'] = origin
      req.params['to'] = destination
    end

    parsed_json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'http://www.mapquestapi.com/')
  end
end
