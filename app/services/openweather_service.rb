class OpenweatherService
  def self.get_forecast(location)
    response = connection.get('/data/2.5/onecall') do |req|
      req.params['lat'] = location.lat
      req.params['lon'] = location.lng
      req.params['appid'] = ENV['OPENWEATHER_KEY']
      req.params['exclude'] = 'minutely,alerts'
      req.params['units'] = 'imperial'
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_forecast_at_arrival(location)
    response = connection.get('/data/2.5/onecall') do |req|
      req.params['lat'] = location.lat
      req.params['lon'] = location.lng
      req.params['appid'] = ENV['OPENWEATHER_KEY']
      req.params['exclude'] = 'current,minutely,alerts'
      req.params['units'] = 'imperial'
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def self.connection
    Faraday.new(url: 'https://api.openweathermap.org')
  end
end
