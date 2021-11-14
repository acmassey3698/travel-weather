require 'rails_helper'

RSpec.describe 'background image request' do
  describe 'happy path' do
    it 'returns an image when the city is provided', :vcr do
      get '/api/v1/backgrounds?location=Denver,CO'

      expect(response).to be_successful
      response_body = JSON.parse(response.body, symbolize_names:true)

      image_attributes = response_body[:data][:attributes][:image]

      expect(response_body).to have_key :data
      expect(response_body[:data][:type]).to eq("image")
      expect(response_body[:data][:id]).to eq(nil)
      expect(image_attributes[:location]).to eq('Denver,CO')
      expect(image_attributes[:image_url]).to be_a(String)
      expect(image_attributes[:credit][:author]).to be_a(String)
      expect(image_attributes[:credit][:profile]).to be_a(String)
    end
  end

  describe 'sad path' do
    it 'returns an error when there is not result for the photo search', :vcr do
      get '/api/v1/backgrounds?location=dafgewgqwaggeqwgag'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      parsed = JSON.parse(response.body, symbolize_names:true)

      expect(parsed[:message]).to eq("No results found")
      expect(parsed[:error]).to eq("No results found for location: dafgewgqwaggeqwgag")
    end
  end

  describe 'edge case' do
    it 'returns an error when the location is not provided for a photo search', :vcr do
      get '/api/v1/backgrounds?location='

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      parsed = JSON.parse(response.body, symbolize_names:true)

      expect(parsed[:message]).to eq("Bad request")
      expect(parsed[:error]).to eq("Query missing required information")
    end
  end
end
