require 'rails_helper'

RSpec.describe ImageService do
  describe 'class methods' do
    it "#search", :vcr do
      response = ImageService.search('Denver,CO')
      result = JSON.parse(response.body, symbolize_names:true)
      expect(result).to have_key :results
      expect(result[:results]).to be_an Array
      expect(result[:results][0][:urls]).to have_key :regular
      expect(result[:results][0][:user]).to have_key :username
      expect(result[:results][0][:user]).to have_key :links
    end
  end
end
