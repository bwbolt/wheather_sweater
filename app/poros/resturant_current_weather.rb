class ResturantCurrentWeather
  attr_reader :summary, :temperature

  def initialize(data)
    @summary = data.conditions
    @temperature = data.temperature.to_s
  end
end
