require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  describe 'when I send a get request to the "merchant/:id/items" path' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1)
      @item_3 = create(:item, merchant: @merchant_1)
      @item_4 = create(:item, merchant: @merchant_2)
      @item_5 = create(:item, merchant: @merchant_2)

      @items = [@item_1, @item_2, @item_3]

      get "/api/v1/merchants/#{@merchant_1.id}/items"
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response with all items associated with merchant' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)

      items = @hash['data']
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
