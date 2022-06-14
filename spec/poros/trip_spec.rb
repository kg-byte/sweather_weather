require 'rails_helper'

RSpec.describe Trip do 
  it 'exists and has attributes' do 
    route_data = JSON.parse(File.read('spec/fixtures/mapquest_route.json'), symbolize_names: true)
    trip = Trip.new('denver,co', 'los angeles,ca', route_data)

    expect(trip).to be_a(Trip)
    expect(trip.start_city).to eq('denver,co')
    expect(trip.end_city).to eq('los angeles,ca')
    expect(trip.travel_time).to eq('40 hours, 16 minutes')
    expect(trip.destination_geocode).to eq({:lat=>41.596916, :lng=>-118.244469})
  end


end