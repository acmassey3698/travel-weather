require 'rails_helper'

RSpec.describe 'user registration endpoint' do
  describe 'happy path' do
    it 'successfully creates a user', :vcr do
      post '/api/v1/users', params: {
        email: 'email@email.com',
        password: 'abc123',
        password_confirmation: 'abc123'
      } , as: :json

      expect(response).to be_successful

    end
  end

  describe 'sad path' do

  end

  describe 'edge case' do

  end

end
