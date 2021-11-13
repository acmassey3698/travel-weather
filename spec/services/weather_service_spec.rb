require 'rails_helper'

RSpec.describe WeatherService do
  describe 'class methods' do
    it '#weather_data', :vcr do
      coords = {
        latitude: 33.44,
        longitude: -94.04
      }
      response = WeatherService.weather_data(coords)
      parsed = JSON.parse(response.body, symbolize_names:true)
      expect(parsed).to be_a(Hash)
      expect(parsed).to have_key :current
      expect(parsed).to have_key :daily
      expect(parsed).to have_key :hourly
    end
  end
end
