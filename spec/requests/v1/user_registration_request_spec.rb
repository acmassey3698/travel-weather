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
    it 'does not authenticate when the user misvalidates their password', :vcr do
      post '/api/v1/users', params: {
        email: 'email@email.com',
        password: 'abc123',
        password_confirmation: '23'
      } , as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:message]).to eq("Unauthorized")
      expect(response_body[:error]).to eq("Invalid credentials provided")
    end

    it 'does not allow for two users with the same email', :vcr do
      user1 = User.create!(email: 'yaknow@mail.com', password: "abc", password_confirmation: "abc")

      post '/api/v1/users', params: {
        email: 'yaknow@mail.com',
        password: 'abc123',
        password_confirmation: 'abc123'
      } , as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:message]).to eq("Unauthorized")
      expect(response_body[:error]).to eq("Invalid credentials provided")
    end
  end

  describe 'edge case' do
    it 'does not authenticate when there is no email provided', :vcr do
      post '/api/v1/users', params: {
        email: '',
        password: 'abc123',
        password_confirmation: 'abc123'
      } , as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:message]).to eq("Unauthorized")
      expect(response_body[:error]).to eq("Invalid credentials provided")
    end
  end
end
