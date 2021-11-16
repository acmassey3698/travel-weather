require 'rails_helper'

RSpec.describe 'road trip create request' do
  before :each do
    @user1 = User.create!(
      email: 'java@java.com',
      password: 'java',
      password_confirmation: 'java',
      api_key: SecureRandom.hex
    )
  end

  describe 'happy path' do
    it 'successfully creates a road trip', :vcr do
      post '/api/v1/road_trip', params: {
        origin: "Denver,CO",
        destination: "Las Vegas,NV",
        api_key: @user1.api_key
      } , as: :json

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to have_key :data
      expect(response_body[:data][:id]).to be_falsey
      expect(response_body[:data][:type]).to eq('roadtrip')
      expect(response_body[:data][:attributes][:start_city]).to eq('Denver,CO')
      expect(response_body[:data][:attributes][:end_city]).to eq('Las Vegas,NV')
      expect(response_body[:data][:attributes][:travel_time]).to be_a String
      expect(response_body[:data][:attributes][:weather_at_eta][:temperature]).to be_a Numeric
      expect(response_body[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
    end

    it 'does it for a short trip', :vcr do
      post '/api/v1/road_trip', params: {
        origin: "Charlotte,NC",
        destination: "Gastonia,NC",
        api_key: @user1.api_key
      } , as: :json

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to have_key :data
      expect(response_body[:data][:id]).to be_falsey
      expect(response_body[:data][:type]).to eq('roadtrip')
      expect(response_body[:data][:attributes][:start_city]).to eq('Charlotte,NC')
      expect(response_body[:data][:attributes][:end_city]).to eq('Gastonia,NC')
      expect(response_body[:data][:attributes][:travel_time]).to be_a String
      expect(response_body[:data][:attributes][:weather_at_eta][:temperature]).to be_a Numeric
      expect(response_body[:data][:attributes][:weather_at_eta][:conditions]).to be_a String
    end
  end

  describe 'sad path' do

  end

  describe 'edge case' do

  end
end
