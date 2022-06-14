require 'rails_helper'

RSpec.describe MapquestFacade do
  it 'returns a hash of geocode' do
    data = JSON.parse(File.read('spec/fixtures/mapquest_response.json'), symbolize_names: true)
    allow(MapquestService).to receive(:get_geocode).and_return(data)

    geocode = MapquestFacade.get_geocode('denver,co')
    expect(geocode).to be_a(Hash)
    expect(geocode[:lat]).to eq(39.738453)
    expect(geocode[:lng]).to eq(-104.984853)
  end

  it 'returns route data' do
    data = JSON.parse(File.read('spec/fixtures/mapquest_route.json'), symbolize_names: true)

    allow(MapquestService).to receive(:get_route).and_return(data)

    trip = MapquestFacade.get_route('denver,co', 'los angeles,ca')

    expect(trip).to be_a(Trip)
    expect(trip.start_city).to eq('denver,co')
    expect(trip.end_city).to eq('los angeles,ca')
    expect(trip.travel_time).to eq('40 hours, 16 minutes')
    expect(trip.destination_geocode).to eq({:lat=>41.596916, :lng=>-118.244469})  

  end
end
