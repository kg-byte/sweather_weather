require 'rails_helper'

RSpec.describe CurrentWeather do 
  it 'exists and has attributes' do 
  	params = {
        "dt": 1654988714,
        "sunrise": 1654947095,
        "sunset": 1655000870,
        "temp": 97.39,
        "feels_like": 92.71,
        "pressure": 1003,
        "humidity": 13,
        "dew_point": 38.35,
        "uvi": 3.42,
        "clouds": 76,
        "visibility": 10000,
        "wind_speed": 1.99,
        "wind_deg": 240,
        "wind_gust": 3,
        "weather": [
            {
                "id": 803,
                "main": "Clouds",
                "description": "broken clouds",
                "icon": "04d"
            }
        ]
    }

    current_weather = CurrentWeather.new(params)
    expect(current_weather).to be_a(CurrentWeather)
    expect(current_weather.datetime).to eq('2022-06-11 17:05:14 -0600')
    expect(current_weather.sunrise).to eq('2022-06-11 05:31:35 -0600')
    expect(current_weather.sunset).to eq('2022-06-11 20:27:50 -0600')
    expect(current_weather.temperature).to eq(97.39)
    expect(current_weather.feels_like).to eq(92.71)
    expect(current_weather.humidity).to eq(13)
    expect(current_weather.visibility).to eq(10000)
    expect(current_weather.uvi).to eq(3.42)
    expect(current_weather.conditions).to eq('broken clouds')
  end



end