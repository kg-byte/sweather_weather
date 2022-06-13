class OpenweatherFacade
  def self.get_weather(geocode)
    weather_data = OpenweatherService.get_weather(geocode[:lat], geocode[:lng])
    current_weather = CurrentWeather.new(weather_data[:current])
    daily_weather = weather_data[:daily][1..5].map { |data| DailyWeather.new(data) }
    hourly_weather = weather_data[:hourly][1..8].map { |data| HourlyWeather.new(data) }
    { current_weather: current_weather, daily_weather: daily_weather, hourly_weather: hourly_weather }
  end
end
