require 'rails_helper'

RSpec.describe 'user registration endpoint' do
  describe 'happy path' do
    it 'successfully creates a user', :vcr do
      post '/api/v1/users', params: {
        email: 'email@email.com',
        password: 'abc123',
        password_confirmation: 'abc123'
      } , as: :json

      expect(response).to be_successful
      expect(response.status).to eq(201)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to have_key :data
      expect(response_body[:data][:type]).to eq("users")
      expect(response_body[:data][:id].to_i).to be_truthy
      expect(response_body[:data][:attributes][:email]).to eq("email@email.com")
      expect(response_body[:data][:attributes][:api_key]).to be_a String
    end
  end

  describe 'sad path' do

  end

  describe 'edge case' do

  end

end
