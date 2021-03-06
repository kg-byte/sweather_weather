require 'rails_helper'

RSpec.describe 'Weather API', :vcr do
  let!(:user) { User.create(email: 'sample.email.com', password: 'password') }
  let!(:api_key) { user.api_keys.create(token: 'abc') }

  describe 'happy path' do
    it 'sends serialized current, daily and hourly weather forecast' do
      data = JSON.parse(File.read('spec/fixtures/openweather_response.json'), symbolize_names: true)
      allow(OpenweatherService).to receive(:get_weather).and_return(data)
      get '/api/v1/forecast?location=denver,co', headers: { 'Authorization' => 'Bearer abc' }

      expect(response).to be_successful
      weather = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(weather[:id]).to eq(nil)
      expect(weather[:type]).to eq('forecast')
      expect(weather[:attributes]).to be_a(Hash)

      expect(weather[:attributes][:current_weather][:datetime]).to be_a(String)
      expect(weather[:attributes][:current_weather][:sunrise]).to be_a(String)
      expect(weather[:attributes][:current_weather][:sunset]).to be_a(String)
      expect(weather[:attributes][:current_weather][:temperature]).to be_a(Float)
      expect(weather[:attributes][:current_weather][:feels_like]).to be_a(Float)
      expect(weather[:attributes][:current_weather][:humidity]).to be_an(Integer)
      expect(weather[:attributes][:current_weather][:visibility]).to be_an(Integer)
      expect(weather[:attributes][:current_weather][:uvi]).to be_an(Float)
      expect(weather[:attributes][:current_weather][:conditions]).to be_a(String)
      expect(weather[:attributes][:current_weather][:icon]).to be_a(String)
      expect(weather[:attributes][:current_weather]).to_not have_key(:wind_speed)

      expect(weather[:attributes][:daily_weather]).to be_an(Array)
      expect(weather[:attributes][:daily_weather].count).to eq(5)
      weather[:attributes][:daily_weather].each do |weather|
        expect(weather[:date]).to be_a(String)
        expect(weather[:sunrise]).to be_a(String)
        expect(weather[:sunset]).to be_a(String)
        expect(weather[:max_temp]).to be_a(Float)
        expect(weather[:min_temp]).to be_a(Float)
        expect(weather[:conditions]).to be_a(String)
        expect(weather[:icon]).to be_a(String)
        expect(weather).to_not have_key(:moonrise)
      end

      expect(weather[:attributes][:hourly_weather]).to be_an(Array)
      expect(weather[:attributes][:hourly_weather].count).to eq(8)
      weather[:attributes][:hourly_weather].each do |weather|
        expect(weather[:time]).to be_a(String)
        expect(weather[:temperature]).to be_a(Float)
        expect(weather[:conditions]).to be_a(String)
        expect(weather[:icon]).to be_a(String)
        expect(weather).to_not have_key(:feels_like)
      end
    end
  end

  describe 'sad paths' do
    it 'handles edge case with no params' do
      get '/api/v1/forecast', headers: { 'Authorization' => 'Bearer abc' }

      results = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(400)
      expect(results[:error]).to eq('Location parameter is required')
    end

    it 'handles edge case with empty params' do
      get '/api/v1/forecast?location=', headers: { 'Authorization' => 'Bearer abc' }

      item_found = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(response.status).to eq(400)
      expect(item_found[:error]).to eq('Location parameter cannot be empty')
    end
  end
end
