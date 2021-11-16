require 'rails_helper'

RSpec.describe 'activity request spec' do
  describe 'happy path' do
    it 'returns activites when a user enters a valid location', :vcr do
      get '/api/v1/activities?destination=Denver,CO'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to have_key :data
      expect(response_body[:data][:id]).to be_falsey
      expect(response_body[:data][:type]).to eq('activities')
      expect(response_body[:data][:attributes]).to have_key :activities
      expect(response_body[:data][:attributes]).to have_key :destination
      expect(response_body[:data][:attributes]).to have_key :forecast

      expect(response_body[:data][:attributes][:destination]).to eq("Denver,CO")
      expect(response_body[:data][:attributes][:forecast][:temperature]).to be_a String
      expect(response_body[:data][:attributes][:forecast][:summary]).to be_a String
      expect(response_body[:data][:attributes][:activities]).to be_an Array

      response_body[:data][:attributes][:activities].each do |activity|
        expect(activity[:title]).to be_a String
        expect(activity[:type]).to be_a String
        expect(activity[:participants]).to be_a Numeric
        expect(activity[:price]).to be_a Numeric
      end
    end
  end

  describe 'sad path' do
    it 'returns an error when there is no city that matches the destination', :vcr do
      get '/api/v1/activities?destination=faefgegfaweg'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to_not have_key :data
      expect(response_body[:message]).to eq("No results found")
      expect(response_body[:error]).to eq("No results found for location: faefgegfaweg")
    end
  end

  describe 'edge case' do
    it 'returns the bad request error when a user does not include the destination param', :vcr do
      get '/api/v1/activities'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to_not have_key :data
      expect(response_body[:message]).to eq("Bad request")
      expect(response_body[:error]).to eq("Query missing required information")
    end
  end
end
