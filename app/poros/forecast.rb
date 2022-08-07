class Forecast
  attr_reader :id, :daily_weather, :hourly_weather, :current_weather

  def initialize(current, hourly, daily)
    @id = nil
    @current_weather = current
    @daily_weather = daily
    @hourly_weather = hourly
  end

  def self.create_forecast(data)
    current = CurrentWeather.new(data[:current])
    hourly = data[:hourly].first(8).map { |h| HourlyWeather.new(h) }
    daily = data[:daily].first(5).map { |h| DailyWeather.new(h) }

    Forecast.new(current, hourly, daily)
  end
end
