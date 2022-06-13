require 'rails_helper'

RSpec.describe 'Weather API', :vcr do
  let!(:user1) { User.create(email: 'sample.email.com', password: 'password') }
  let!(:api_key) { user1.api_keys.create(token: 'abc') }

  describe 'happy path' do 
    it 'creates a new user and receives an api token' do
      params = {
                     "email": "whatever@example.com",
                  "password": "password",
     "password_confirmation": "password"
                }
      headers = {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json'
      }
      post '/api/v1/users',  headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(201)
      results = JSON.parse(response.body, symbolize_names: true)[:data]
      api_key = ApiKey.last
      user = User.last 

      expect(results[:type]).to eq('users')
      expect(results[:id]).to eq(user.id)
      expect(results[:attributes]).to be_a(Hash)
      expect(results[:attributes][:email]).to eq('whatever@example.com')
      expect(results[:attributes][:api_key]).to eq(api_key.token)    
    end
  end

  describe 'sad path' do 

  end
end
