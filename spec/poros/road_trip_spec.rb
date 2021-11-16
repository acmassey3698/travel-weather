require 'rails_helper'

RSpec.describe RoadTrip do
  describe 'initialize' do
    it 'exists with attributes', :vcr do
      result = RoadTripFacade.new_trip('Denver,CO', 'Houston,TX')

      expect(result.start_city).to eq('Denver,CO')
      expect(result.end_city).to eq('Houston,TX')
      expect(result.travel_time).to eq("15:38:27")
      expect(result.weather_at_eta[:temperature]).to eq(68.7)
      expect(result.weather_at_eta[:conditions]).to eq("clear sky")
    end
  end

  describe 'instance methods' do
    it '#arrival_weather for a very short trip', :vcr do
      result = RoadTripFacade.new_trip('Charlotte,NC', 'Gastonia,NC')

      expect(result.weather_at_eta[:temperature]).to eq(63.73)
      expect(result.weather_at_eta[:conditions]).to eq('clear sky')
    end

    it '#arrival_weather for a very long trip', :vcr do
      result = RoadTripFacade.new_trip('Charlotte,NC', 'Anchorage,AK')

      expect(result.weather_at_eta[:temperature]).to eq(0.05)
      expect(result.weather_at_eta[:conditions]).to eq('overcast clouds')
    end
  end
end
