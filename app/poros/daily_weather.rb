class DailyWeather
  def initialize(data)
    @date = Time.at(data[:dt]).strftime('%m/%d/%Y')
    @sunrise = Time.at(data[:sunrise])
    @sunset = Time.at(data[:sunset])
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end
end
