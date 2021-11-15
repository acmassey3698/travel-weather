require 'rails_helper'

RSpec.describe 'road trip create request' do
  before :each do
    @user1 = User.create!(
      email: 'java@java.com',
      password: 'java',
      password_confirmation: 'java'
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
    end

    it 'does it for a short trip', :vcr do
      post '/api/v1/road_trip', params: {
        origin: "Charlotte,NC",
        destination: "Gastonia,NC",
        api_key: @user1.api_key
      } , as: :json

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names:true)
    end
  end

  describe 'sad path' do

  end

  describe 'edge case' do

  end
end
