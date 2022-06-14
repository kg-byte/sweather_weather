class OpenweatherFacade
  class << self
    def get_weather(geocode)
      { current_weather: current_weather(geocode), daily_weather: daily_weather(geocode),
        hourly_weather: hourly_weather(geocode) }
    end

    def get_weather_at_eta(geocode, hours)
      HourlyWeather.new(weather_data(geocode)[:hourly][hours])
    end

    private

    def weather_data(geocode)
      data ||= OpenweatherService.get_weather(geocode[:lat], geocode[:lng])
    end

    def current_weather(geocode)
      CurrentWeather.new(weather_data(geocode)[:current])
    end

    def daily_weather(geocode)
      weather_data(geocode)[:daily][1..5].map { |data| DailyWeather.new(data) }
    end

    def hourly_weather(geocode)
      weather_data(geocode)[:hourly][1..8].map { |data| HourlyWeather.new(data) }
    end
  end
end
