require 'rails_helper'

RSpec.describe 'activity request spec' do
  describe 'happy path' do
    it 'returns activites when a user enters a valid location', :vcr do
      get '/api/v1/activites?destination=Denver,CO'

      expect(response).to be_successful

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to have_key :data
      expect(response_body[:data][:id]).to be_falsey
      expect(response_body[:data][:type]).to eq('activities')
      expect(response_body[:data][:attributes]).to have_key :activities
      expect(response_body[:data][:attributes]).to have_key :destination
      expect(response_body[:data][:attributes]).to have_key :forecast
    end 
  end

  describe 'sad path' do

  end

  describe 'edge case' do


  end

end
