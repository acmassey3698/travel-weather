require 'rails_helper'

RSpec.describe BoredService do
  describe 'class methods' do
    it '#relaxation_activity', :vcr do
      response = BoredService.activity
      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:type]).to eq("relaxation")
    end

    it '#weather_dependent', :vcr do
      response = BoredService.activity("recreational")
      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:type]).to eq("recreational")

      response = BoredService.activity("busywork")
      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:type]).to eq("busywork")

      response = BoredService.activity("cooking")
      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:type]).to eq("cooking")
    end
  end
end
