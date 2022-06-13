require 'rails_helper'

RSpec.describe MapquestService do
  it 'returns geocode data', :vcr do
    data = MapquestService.get_geocode('denver, co')

    expect(data).to be_a(Hash)
    expect(data[:results]).to be_an(Array)
    expect(data[:results][0]).to have_key(:locations)
    expect(data[:results][0][:locations][0][:adminArea5]).to eq('Denver')
    expect(data[:results][0][:locations][0][:adminArea3]).to eq('CO')
    expect(data[:results][0][:locations][0]).to have_key(:latLng)
    expect(data[:results][0][:locations][0][:latLng]).to eq({ lat: 39.738453, lng: -104.984853 })
  end
end
