require 'rails_helper'

RSpec.describe Image do
  describe 'initialize' do
    it 'exists with attributes', :vcr do
      image = BackgroundsFacade.search_image('Denver,CO')

      expect(image.location).to be_a String
      expect(image.image_url).to be_a String
      expect(image.author).to be_a String
      expect(image.profile).to be_a String
    end
  end
end
