require 'rails_helper'

RSpec.describe 'city weather request' do
  describe 'happy path' do
    it 'gets the weather data', :vcr do
      get '/api/v1/forecast?location=denver,co'

      expect(response).to be_successful

      response_data = JSON.parse(response.body, symbolize_names:true)[:data]

      #top level
      expect(response_data[:type]).to eq("forecast")
      expect(response_data[:id]).to eq(nil)
      #current_weather
      expect(response_data[:attributes][:current_weather][:datetime]).to be_a String
      expect(response_data[:attributes][:current_weather][:sunrise]).to be_a String
      expect(response_data[:attributes][:current_weather][:sunset]).to be_a String
      expect(response_data[:attributes][:current_weather][:temperature]).to be_a Numeric
      expect(response_data[:attributes][:current_weather][:feels_like]).to be_a Numeric
      expect(response_data[:attributes][:current_weather][:humidity]).to be_a Numeric
      expect(response_data[:attributes][:current_weather][:uvi]).to be_a Numeric
      expect(response_data[:attributes][:current_weather][:visibility]).to be_a Numeric
      expect(response_data[:attributes][:current_weather][:conditions]).to be_a String
      expect(response_data[:attributes][:current_weather][:icon]).to be_a String
      #daily_weather
      expect(response_data[:attributes][:daily_weather].length).to eq(5)
      response_data[:attributes][:daily_weather].each do |day|
        expect(day[:date]).to be_a String
        expect(day[:sunrise]).to be_a String
        expect(day[:sunset]).to be_a String
        expect(day[:max_temp]).to be_a Numeric
        expect(day[:min_temp]).to be_a Numeric
        expect(day[:conditions]).to be_a String
        expect(day[:icon]).to be_a String
      end
      #hourly weather
      expect(response_data[:attributes][:hourly_weather].length).to eq(8)
      response_data[:attributes][:hourly_weather].each do |hour|
        expect(hour[:time]).to be_a String
        expect(hour[:temperature]).to be_a Numeric
        expect(hour[:conditions]).to be_a String
        expect(hour[:icon]).to be_a String
      end
    end
  end
end
