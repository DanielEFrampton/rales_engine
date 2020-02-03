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
      expect(attributes.length).to eq(5)

      expect(attributes['name']).to eq(@item_1.name)
      expect(attributes['id']).to eq(@item_1.id)
      expect(attributes['description']).to eq(@item_1.description)
      expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                             @item_1.unit_price / 100.0))
      expect(attributes['merchant_id']).to eq(@item_1.merchant_id)
    end
  end
end
