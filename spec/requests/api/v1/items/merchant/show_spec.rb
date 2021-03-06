require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @item = create(:item, merchant: @merchant)
  end

  describe 'when I send a request to the item-merchant endpoint' do
    before(:each) do
      get "/api/v1/items/#{@item.id}/merchant"
      @hash = JSON.parse(response.body)
    end

    it 'I get JSON data for the merchant associated with item' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)
      expect(@hash['data'].class).to eq(Hash)

      expect(@hash['data']['id']).to eq(@merchant.id.to_s)
      expect(@hash['data']['type']).to eq('merchant')
      expect(@hash['data']['attributes'].class).to eq(Hash)
      expect(@hash['data']['attributes'].length).to eq(2)
      expect(@hash['data']['attributes']['name']).to eq(@merchant.name.to_s)
      expect(@hash['data']['attributes']['id']).to eq(@merchant.id)
    end
  end
end
