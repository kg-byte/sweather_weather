require 'rails_helper'

RSpec.describe HourlyWeather do
  it 'exists and has attributes' do
    params = {
      "dt": 1_654_988_400,
      "temp": 97.39,
      "feels_like": 92.71,
      "pressure": 1003,
      "humidity": 13,
      "dew_point": 38.35,
      "uvi": 3.42,
      "clouds": 76,
      "visibility": 10_000,
      "wind_speed": 4.12,
      "wind_deg": 222,
      "wind_gust": 9.1,
      "weather": [
        {
          "id": 803,
          "main": 'Clouds',
          "description": 'broken clouds',
          "icon": '04d'
        }
      ],
      "pop": 0
    }

    hourly_weather = HourlyWeather.new(params)
    expect(hourly_weather).to be_a(HourlyWeather)
    expect(hourly_weather.time).to be_a(String)
    expect(hourly_weather.temperature).to eq(97.39)
    expect(hourly_weather.conditions).to eq('broken clouds')
    expect(hourly_weather.icon).to eq('04d')
  end
end
