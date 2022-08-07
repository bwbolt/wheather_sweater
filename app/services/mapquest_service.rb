class MapquestService
  def self.get_coord(location)
    response = connection.get("/geocoding/v1/address?key=#{ENV['MAPQUEST_KEY']}&location=#{location}")

    parsed_json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'http://www.mapquestapi.com/')
  end
end
