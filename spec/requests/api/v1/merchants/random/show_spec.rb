require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end

  describe 'when I send a get request to the merchants random path' do
    before(:each) do
      srand(123) # Arbitrarily set RNG seed so that .sample always picks third

      get "/api/v1/merchants/random"
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of a random merchant' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(["data"])
      expect(@hash["data"].length).to eq(3)
      expect(@hash["data"].class).to eq(Hash)

      expect(@hash["data"]["id"]).to eq("#{@merchant_3.id}")
      expect(@hash["data"]["type"]).to eq("merchant")
      expect(@hash["data"]["attributes"].class).to eq(Hash)
      expect(@hash["data"]["attributes"].length).to eq(2)
      expect(@hash["data"]["attributes"]["name"]).to eq("#{@merchant_3.name}")
      expect(@hash["data"]["attributes"]["id"]).to eq(@merchant_3.id)

      expect(@hash.to_s).not_to include("#{@merchant_1.name}")
      expect(@hash.to_s).not_to include("#{@merchant_2.name}")
    end
  end
end
