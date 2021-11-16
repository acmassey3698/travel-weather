require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'class methods' do
    it '#new_trip hitting #valid_trip', :vcr do
      result = RoadTripFacade.new_trip('Denver,CO', 'Portland,OR')
      expect(result).to be_a RoadTrip
      expect(result.start_city).to be_a String
      expect(result.end_city).to be_a String
      expect(result.travel_time).to be_a String
      expect(result.weather_at_eta).to be_a Hash
      expect(result.weather_at_eta[:temperature]).to be_a Numeric
      expect(result.weather_at_eta[:conditions]).to be_a String
    end

    it '#new_trip hitting #invalid_trip', :vcr do
      result = RoadTripFacade.new_trip('Denver,CO', 'London,UK')

      expect(result).to be_a RoadTrip
      expect(result.start_city).to be_a String
      expect(result.end_city).to be_a String
      expect(result.travel_time).to be_a String
      expect(result.travel_time).to eq("impossible route")
      expect(result.weather_at_eta).to be_a Hash
      expect(result.weather_at_eta[:temperature]).to be_falsey
      expect(result.weather_at_eta[:conditions]).to be_falsey
    end

    it '#destination_forecast', :vcr do
      result = RoadTripFacade.destination_forecast('Denver,CO')

      expect(result).to be_a Forecast
      expect(result.current_weather).to be_a Hash
      expect(result.daily_weather).to be_a Array
      expect(result.hourly_weather).to be_a Array
    end
  end
end
