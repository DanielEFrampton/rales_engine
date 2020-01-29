require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end

  describe 'when I send a get request to the merchants index path' do
    before(:each) do
      get '/api/v1/merchants'
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of all merchants' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(["data"])
      expect(@hash["data"].length).to eq(3)

      expect(@hash["data"][0]["id"]).to eq("#{@merchant_1.id}")
      expect(@hash["data"][0]["type"]).to eq("merchant")
      expect(@hash["data"][0]["attributes"].class).to eq(Hash)
      expect(@hash["data"][0]["attributes"].length).to eq(2)
      expect(@hash["data"][0]["attributes"]["name"]).to eq("#{@merchant_1.name}")
      expect(@hash["data"][0]["attributes"]["id"]).to eq(@merchant_1.id)

      expect(@hash["data"][1]["id"]).to eq("#{@merchant_2.id}")
      expect(@hash["data"][1]["type"]).to eq("merchant")
      expect(@hash["data"][1]["attributes"].class).to eq(Hash)
      expect(@hash["data"][1]["attributes"].length).to eq(2)
      expect(@hash["data"][1]["attributes"]["name"]).to eq("#{@merchant_2.name}")
      expect(@hash["data"][1]["attributes"]["id"]).to eq(@merchant_2.id)

      expect(@hash["data"][2]["id"]).to eq("#{@merchant_3.id}")
      expect(@hash["data"][2]["type"]).to eq("merchant")
      expect(@hash["data"][2]["attributes"].class).to eq(Hash)
      expect(@hash["data"][2]["attributes"].length).to eq(2)
      expect(@hash["data"][2]["attributes"]["name"]).to eq("#{@merchant_3.name}")
      expect(@hash["data"][2]["attributes"]["id"]).to eq(@merchant_3.id)
    end
  end
end
