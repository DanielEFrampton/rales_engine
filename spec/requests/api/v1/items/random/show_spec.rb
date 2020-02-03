# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @names = [@item_1.name, @item_2.name, @item_3.name]
    @descriptions = [@item_1.description,
                    @item_2.description,
                    @item_3.description]
    @merchant_ids = [@item_1.merchant_id,
                     @item_2.merchant_id,
                     @item_3.merchant_id]
    @ids = [@item_1.id, @item_2.id, @item_3.id]
    @unit_prices = [sprintf('%.2f', @item_1.unit_price_decimal),
                    sprintf('%.2f', @item_2.unit_price_decimal),
                    sprintf('%.2f', @item_3.unit_price_decimal)]
  end

  describe 'when I send a get request to the customers random path' do
    before(:each) do
      get '/api/v1/items/random'
      @json = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of a random customer' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)
      expect(@json['data'].class).to eq(Hash)

      expect(@ids).to include(@json['data']['id'].to_i)
      expect(@json['data']['type']).to eq('item')

      attributes = @json['data']['attributes']
      expect(attributes.class).to eq(Hash)
      expect(attributes.length).to eq(5)

      expect(@names).to include(attributes['name'])
      expect(@descriptions).to include(attributes['description'])
      expect(@ids).to include(attributes['id'])
      expect(@unit_prices).to include(attributes['unit_price'])
      expect(@merchant_ids).to include(attributes['merchant_id'])
    end
  end
end
