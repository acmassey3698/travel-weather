require 'rails_helper'

RSpec.describe 'City Weather request' do
  describe 'happy path' do
    it 'gets the weather data' do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      
    end
  end
end
