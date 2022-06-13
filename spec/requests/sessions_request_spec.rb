require 'rails_helper'

RSpec.describe 'User Login', :vcr do
  let!(:user) { User.create(email: 'sample.email.com', password: 'password') }
  let!(:api_key) { user.api_keys.create(token: 'abc') }

  describe 'happy path' do
    it 'returns user info and ok status when credentials are valid' do
      params = {
        "email": 'sample.email.com',
        "password": 'password'
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(200)
      results = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(results[:type]).to eq('users')
      expect(results[:id]).to eq(user.id)
      expect(results[:attributes]).to be_a(Hash)
      expect(results[:attributes][:email]).to eq('sample.email.com')
      expect(results[:attributes][:api_key]).to eq('abc')
    end
  end

  describe 'sad path' do
    it 'missing email' do
      params = {
        "email": '',
        "password": 'password'
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

      results = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(401)
      expect(results[:error]).to eq("Incorrect Credentials. Please try again!")
    end

    it 'missing password' do
      params = {
        "email": 'sample.email.com',
        "password": ''
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

      results = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(401)
      expect(results[:error]).to eq("Incorrect Credentials. Please try again!")
    end

    it 'wrong password' do
      params = {
        "email": 'sample.email.com',
        "password": 'wrongpassword'
      }
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
      post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

      results = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response.status).to eq(401)
      expect(results[:error]).to eq("Incorrect Credentials. Please try again!")
    end
  end
end
