require 'rails_helper'

RSpec.describe 'user login' do
  before :each do
    @user1 = User.create!(
      email: 'mail@mail.com',
      password: 'abc123',
      password_confirmation: 'abc123',
      api_key: SecureRandom.hex
    )
  end

  describe 'happy path' do
    it 'logs in a user that is already registered' do
      post '/api/v1/sessions', params: {
        email: @user1.email,
        password: @user1.password
      }, as: :json

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body).to have_key :data
      expect(response_body[:data][:type]).to eq("users")
      expect(response_body[:data][:id].to_i).to be_truthy
      expect(response_body[:data][:attributes][:email]).to eq(@user1.email)
      expect(response_body[:data][:attributes][:api_key]).to eq(@user1.api_key)
    end
  end

  describe 'sad path' do
    it 'returns an error when the wrong password is given' do
      post '/api/v1/sessions', params: {
        email: @user1.email,
        password: "oops"
      }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:message]).to eq("Unauthorized")
      expect(response_body[:error]).to eq("Invalid credentials provided")
    end

    it 'returns an error when there is no email mathcing the email given' do
      post '/api/v1/sessions', params: {
        email: "unique@mail.com",
        password: @user1.password
      }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:message]).to eq("Unauthorized")
      expect(response_body[:error]).to eq("Invalid credentials provided")
    end
  end

  describe 'edge case' do
    it 'returns an error when the fields are left empty' do
      post '/api/v1/sessions', params: {
        email: "",
        password: ""
      }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response_body[:message]).to eq("Unauthorized")
      expect(response_body[:error]).to eq("Invalid credentials provided")
    end
  end
end
