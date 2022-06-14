require 'rails_helper'

RSpec.describe 'Roadtrip API', :vcr do
 let!(:user1) { User.create(email: 'sample.email.com', password: 'password') }
 let!(:api_key) { user1.api_keys.create(token: 'abc') }

  describe 'happy path' do
    it 'sends serialized trip info when route is valid' do
      data = JSON.parse(File.read('spec/fixtures/mapquest_route.json'), symbolize_names: true)
      allow(MapquestService).to receive(:get_route).and_return(data)
      weather_data = JSON.parse(File.read('spec/fixtures/openweather_response.json'), symbolize_names: true)
      allow(OpenweatherService).to receive(:get_weather).and_return(weather_data)
      
      params = {
         "origin": "Denver,CO",
         "destination": "Los Angeles,CA",
         "api_key": "abc"
       }
      
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(200)
      trip_info = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(trip_info).to be_a(Hash)
      expect(trip_info[:type]).to eq('roadtrip')
      expect(trip_info[:attributes][:start_city]).to eq('Denver,CO')
      expect(trip_info[:attributes][:end_city]).to eq('Los Angeles,CA')
      expect(trip_info[:attributes][:travel_time]).to eq('40 hours, 16 minutes')
      expect(trip_info[:attributes][:weather_at_eta][:temperature]).to eq(83.34)
      expect(trip_info[:attributes][:weather_at_eta][:conditions]).to eq('clear sky')
    end

  it 'sends serialized impossible route info when route is not valid' do
    data = JSON.parse(File.read('spec/fixtures/mapquest_impossible_route.json'), symbolize_names: true)
    allow(MapquestService).to receive(:get_route).and_return(data)
    
    params = {
       "origin": "Denver,CO",
       "destination": "London, UK",
       "api_key": "abc"
     }
    
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

    expect(response.status).to eq(200)
    trip_info = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(trip_info).to be_a(Hash)
    expect(trip_info[:type]).to eq('roadtrip')
    expect(trip_info[:attributes][:start_city]).to eq('Denver,CO')
    expect(trip_info[:attributes][:end_city]).to eq('London, UK')
    expect(trip_info[:attributes][:travel_time]).to eq('impossible route')
    expect(trip_info[:attributes][:weather_at_eta]).to be(nil)
  end

  end

  describe 'sad path' do
    it 'handles sad path invalid api token' do 
      params = {
         "origin": "Denver,CO",
         "destination": "Los Angeles,CA",
         "api_key": "abd"
       }
      
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(401)
      results = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(results[:error]).to eq('Invalid API token!') 
    end
 
  end
end
