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
    it 'returns an error when no api key is provided', :vcr do
      post '/api/v1/road_trip', params: {
        origin: "Charlotte,NC",
        destination: "Gastonia,NC"
      } , as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to_not have_key :data
      expect(response_body[:message]).to eq('Unauthorized')
      expect(response_body[:error]).to eq("Invalid credentials provided")
    end

    it 'returns an error when an incorrect api key is provided', :vcr do
      post '/api/v1/road_trip', params: {
        origin: "Charlotte,NC",
        destination: "Gastonia,NC",
        api_key: "This is not a valid key"
      } , as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to_not have_key :data
      expect(response_body[:message]).to eq('Unauthorized')
      expect(response_body[:error]).to eq("Invalid credentials provided")
    end

    it 'returns an error when the user does not provide place params', :vcr do
      post '/api/v1/road_trip', params: {
        api_key: @user1.api_key
      } , as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to_not have_key :data
      expect(response_body[:message]).to eq('Bad request')
      expect(response_body[:error]).to eq("Query missing required information")

    end

    it 'returns a bad request error when the user does not put valid places', :vcr do
      post '/api/v1/road_trip', params: {
        origin: "@8fwnon",
        destination: "8adh9w",
        api_key: @user1.api_key
      } , as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to_not have_key :data
      expect(response_body[:message]).to eq('No results found')
      expect(response_body[:error]).to eq("No results found for location: 8adh9w")
    end
  end

  describe 'edge case' do
    it 'gives a specific result for impossible routes', :vcr do
      post '/api/v1/road_trip', params: {
        origin: "New York,NY",
        destination: "London,UK",
        api_key: @user1.api_key
      } , as: :json

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to have_key :data
      expect(response_body[:data][:id]).to be_falsey
      expect(response_body[:data][:type]).to eq('roadtrip')
      expect(response_body[:data][:attributes][:start_city]).to eq('New York,NY')
      expect(response_body[:data][:attributes][:end_city]).to eq('London,UK')
      expect(response_body[:data][:attributes][:travel_time]).to eq('impossible route')
      expect(response_body[:data][:attributes][:weather_at_eta][:temperature]).to be_falsey
      expect(response_body[:data][:attributes][:weather_at_eta][:conditions]).to be_falsey
    end
  end
end
