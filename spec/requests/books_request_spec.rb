require 'rails_helper'

RSpec.describe 'Book-search API', :vcr do
  let!(:user) { User.create(email: 'sample.email.com', password: 'password') }
  let!(:api_key) { user.api_keys.create(token: 'abc') }

  describe 'happy path' do
    it 'sends serialized current, daily and hourly weather forecast' do
      data = JSON.parse(File.read('spec/fixtures/openweather_response.json'), symbolize_names: true)
      allow(OpenweatherService).to receive(:get_weather).and_return(data)
      book_data = JSON.parse(File.read('spec/fixtures/openlibrary_response.json'), symbolize_names: true)
      allow(OpenlibraryService).to receive(:get_books).and_return(book_data)

      get '/api/v1/book-search?location=denver,co&quantity=8', headers: { 'Authorization' => 'Bearer abc' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data[:id]).to eq(nil)
      expect(data[:type]).to eq('books')
      expect(data[:attributes]).to be_a(Hash)
      expect(data[:attributes][:destination]).to eq('denver,co')
      expect(data[:attributes][:forecast]).to be_a(Hash)
      expect(data[:attributes][:forecast][:summary]).to eq('broken clouds')
      expect(data[:attributes][:forecast][:temperature]).to eq('97.39 F')
      expect(data[:attributes][:total_books_found]).to eq(42_475)

      expect(data[:attributes][:books]).to be_an(Array)
      expect(data[:attributes][:books].count).to eq(8)

      data[:attributes][:books].each do |book|
        expect(book[:isbn]).to be_a(Array)
        expect(book[:publisher]).to be_an(Array)
        expect(book[:title]).to be_a(String)
        expect(book).to_not have_key(:language)
      end
    end
  end

  describe 'sad paths' do
    it 'handles edge case with no params' do
      get '/api/v1/book-search', headers: { 'Authorization' => 'Bearer abc' }

      results = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(400)
      expect(results[:error]).to eq('Both location and quantity parameters are required')
    end

    it 'handles edge case with empty params' do
      get '/api/v1/book-search?location=&quantity=2', headers: { 'Authorization' => 'Bearer abc' }

      item_found = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(response.status).to eq(400)
      expect(item_found[:error]).to eq('Location and quantity parameters cannot be empty')
    end

    it 'handles edge case with improper quantity' do
      get '/api/v1/book-search?location=denver,co&quantity=-2', headers: { 'Authorization' => 'Bearer abc' }

      item_found = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(400)
      expect(item_found[:error]).to eq('Quantity parameter must be a positive integer')
    end
  end
end
