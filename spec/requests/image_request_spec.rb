require 'rails_helper'

RSpec.describe 'Weather API', :vcr do
  it 'sends serialized current, daily and hourly weather forecast' do
    data = JSON.parse(File.read('spec/fixtures/images_response.json'), symbolize_names: true)
    allow(ImagesService).to receive(:get_image).and_return(data)
    get '/api/v1/backgrounds?location=denver,co'

    expect(response).to be_successful
    image = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(image[:id]).to eq(nil)
    expect(image[:type]).to eq('image')
    expect(image[:attributes]).to be_a(Hash)
    expect(image[:attributes][:image][:location]).to eq('denver,co')
    expect(image[:attributes][:image][:image_url]).to eq('https://images.pexels.com/photos/2706750/pexels-photo-2706750.jpeg')
    expect(image[:attributes][:image][:credit]).to be_a(Hash)
    expect(image[:attributes][:image][:credit][:author]).to eq('Thomas Ward')
    expect(image[:attributes][:image][:credit][:source]).to eq('https://www.pexels.com/photo/union-station-building-2706750/')
    expect(image[:attributes][:image][:credit][:logo]).to eq('https://images.pexels.com/lib/api/pexels.png')
    expect(image[:attributes][:image]).to_not have_key(:height)
    expect(image[:attributes][:image][:credit]).to_not have_key(:photographer_id)
  end
end
