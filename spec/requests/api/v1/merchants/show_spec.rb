require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe 'when I send a get request to the merchants show path' do
    before(:each) do
      get "/api/v1/merchants/#{@merchant_1.id}"
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of all merchants' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(["data"])
      expect(@hash["data"].length).to eq(1)

      expect(@hash["data"][0]["id"]).to eq("#{@merchant_1.id}")
      expect(@hash["data"][0]["type"]).to eq("merchant")
      expect(@hash["data"][0]["attributes"].class).to eq(Hash)
      expect(@hash["data"][0]["attributes"].length).to eq(1)
      expect(@hash["data"][0]["attributes"]["name"]).to eq("#{@merchant_1.name}")

      expect(@hash).not_to have_content(@merchant_2.name)
    end
  end
end
