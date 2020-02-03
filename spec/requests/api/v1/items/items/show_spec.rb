require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
  end

  describe 'when I send a request to the items show endpoint' do
    before(:each) do
      get "/api/v1/items/#{@item_1.id}"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for a single item' do
      expect(@json.class).to eq(Hash)
      expect(@json.length).to eq(1)
      expect(@json['data'].length).to eq(3)

      expect(@json['data']['id']).to eq(@item_1.id.to_s)
      expect(@json['data']['type']).to eq('item')

      attributes = @json['data']['attributes']
      expect(attributes.length).to eq(4)

      expect(attributes['name']).to eq(@items[index].name)
      expect(attributes['description']).to eq(@items[index].description)
      expect(attributes['unit_price']).to eq(@items[index].unit_price)
      expect(attributes['merchant_id']).to eq(@items[index].merchant_id)
    end
  end
end
