require 'rails_helper'

RSpec.describe OpenweatherFacade do 
  it 'returns a hash of different type of weathers' do 
  	data = JSON.parse(File.read('spec/fixtures/openweather_response.json'), symbolize_names: true)
  	allow(OpenweatherService).to receive(:get_weather).and_return(data)

  	results = OpenweatherFacade.get_weather({lat: 39.738453, lng:-104.984853})

  	expect(results).to be_a(Hash)
  	expect(results[:current_weather]).to be_a(CurrentWeather)
  	expect(results[:current_weather].conditions).to eq('broken clouds')
  	
  	expect(results[:daily_weather]).to be_all(DailyWeather)
  	expect(results[:daily_weather].count).to eq(5)
  	expect(results[:daily_weather][0].date).to eq('2022-06-12 12:00:00 -0600')
    
    expect(results[:hourly_weather]).to be_all(HourlyWeather)
    expect(results[:hourly_weather].count).to eq(8)
    expect(results[:hourly_weather][0].time).to eq('6:00 PM')
  end 
end