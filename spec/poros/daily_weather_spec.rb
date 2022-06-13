require 'rails_helper'

RSpec.describe CurrentWeather do
  it 'exists and has attributes' do
    params = { "dt": 1_654_970_400,
               "sunrise": 1_654_947_095,
               "sunset": 1_655_000_870,
               "moonrise": 1_654_990_200,
               "moonset": 1_654_939_140,
               "moon_phase": 0.39,
               "temp": {
                 "day": 94.41,
                 "min": 69.33,
                 "max": 98.19,
                 "night": 76.37,
                 "eve": 96.8,
                 "morn": 69.33
               },
               "feels_like": {
                 "day": 89.73,
                 "night": 75.22,
                 "eve": 92.01,
                 "morn": 67.42
               },
               "pressure": 1004,
               "humidity": 11,
               "dew_point": 32.67,
               "wind_speed": 16.64,
               "wind_deg": 191,
               "wind_gust": 30.18,
               "weather": [
                 {
                   "id": 500,
                   "main": 'Rain',
                   "description": 'light rain',
                   "icon": '10d'
                 }
               ],
               "clouds": 1,
               "pop": 0.32,
               "rain": 0.11,
               "uvi": 10.66 }

    daily_weather = DailyWeather.new(params)
    expect(daily_weather).to be_a(DailyWeather)

    expect(daily_weather.date).to eq('2022-06-11 12:00:00 -0600')
    expect(daily_weather.sunrise).to eq('2022-06-11 05:31:35 -0600')
    expect(daily_weather.sunset).to eq('2022-06-11 20:27:50 -0600')
    expect(daily_weather.min_temp).to eq(69.33)
    expect(daily_weather.max_temp).to eq(98.19)
    expect(daily_weather.conditions).to eq('light rain')
    expect(daily_weather.icon).to eq('10d')
  end
end
