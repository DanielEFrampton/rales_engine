# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice)
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice)
    @ids = [@invoice_item_1.id, @invoice_item_2.id, @invoice_item_3.id]
    @unit_prices = [sprintf('%.2f', @invoice_item_1.unit_price_decimal),
                    sprintf('%.2f', @invoice_item_2.unit_price_decimal),
                    sprintf('%.2f', @invoice_item_3.unit_price_decimal)]
    @item_ids = [@invoice_item_1.item_id,
                 @invoice_item_2.item_id,
                 @invoice_item_3.item_id]
    @invoice_ids = [@invoice_item_1.invoice_id,
                    @invoice_item_2.invoice_id,
                    @invoice_item_3.invoice_id]
    @quantities = [@invoice_item_1.quantity,
                    @invoice_item_2.quantity,
                    @invoice_item_3.quantity]
  end

  describe 'when I send a get request to the invoice_items random path' do
    before(:each) do
      get '/api/v1/invoice_items/random'
      @json = JSON.parse(response.body)
    end

    it 'I getJSON:API data for a random invoice_item record' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)
      expect(@json['data'].class).to eq(Hash)

      expect(@ids).to include(@json['data']['id'].to_i)
      expect(@json['data']['type']).to eq('invoice_item')

      attributes = @json['data']['attributes']
      expect(attributes.class).to eq(Hash)
      expect(attributes.length).to eq(5)
      expect(@quantities).to include(attributes['quantity'])
      expect(@unit_prices).to include(attributes['unit_price'])
      expect(@item_ids).to include(attributes['item_id'])
      expect(@invoice_ids).to include(attributes['invoice_id'])
      expect(@ids).to include(attributes['id'])
    end
  end
end
