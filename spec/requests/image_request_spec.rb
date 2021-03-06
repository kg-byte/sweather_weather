require 'rails_helper'

RSpec.describe 'Image API', :vcr do
  let!(:user) { User.create(email: 'sample.email.com', password: 'password') }
  let!(:api_key) { user.api_keys.create(token: 'abc') }

  describe 'happy path' do
    it 'sends serialized current, daily and hourly weather forecast' do
      data = JSON.parse(File.read('spec/fixtures/images_response.json'), symbolize_names: true)
      allow(ImagesService).to receive(:get_image).and_return(data)
      get '/api/v1/backgrounds?location=denver,co', headers: { 'Authorization' => 'Bearer abc' }

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

  describe 'sad path' do
    it 'handles edge case with no params' do
      get '/api/v1/backgrounds', headers: { 'Authorization' => 'Bearer abc' }

      results = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(400)
      expect(results[:error]).to eq('Location parameter is required')
    end

    it 'handles edge case with empty params' do
      get '/api/v1/backgrounds?location=', headers: { 'Authorization' => 'Bearer abc' }

      item_found = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(response.status).to eq(400)
      expect(item_found[:error]).to eq('Location parameter cannot be empty')
    end
  end
end
