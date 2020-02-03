require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)

    @items = [@item_1, @item_2, @item_3]
  end

  describe 'when I send a request to the items index endpoint' do
    before(:each) do
      get "/api/v1/items/"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all items' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)

      items = @json['data']
      items.each_with_index do |item, index|
        expect(item['id']).to eq(@items[index].id.to_s)
        expect(item['type']).to eq('item')

        attributes = item['attributes']

        expect(attributes['name']).to eq(@items[index].name)
        expect(attributes['description']).to eq(@items[index].description)
        expect(attributes['unit_price']).to eq(sprintf('%.2f',
                                              @items[index].unit_price / 100.0))
        expect(attributes['merchant_id']).to eq(@items[index].merchant_id)
      end
    end
  end
end
