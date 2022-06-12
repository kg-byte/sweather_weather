require 'rails_helper'

RSpec.describe MapquestFacade do 
  # it 'returns a hash of different type of weathers' do 
  it 'returns a a hash of geocode' do 
  	data = JSON.parse(File.read('spec/fixtures/mapquest_response.json'), symbolize_names: true)
  	
  	allow(MapquestService).to receive(:get_geocode).and_return(data)

  	geocode = MapquestFacade.get_geocode('denver,co')
  	expect(geocode).to be_a(Hash)
  	expect(geocode[:lat]).to eq(39.738453)
  	expect(geocode[:lng]).to eq(-104.984853)

  end
end