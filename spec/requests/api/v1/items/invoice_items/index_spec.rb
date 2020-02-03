require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @item = create(:item, merchant: @merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant)
    @invoice_2 = create(:invoice, customer: @customer_2, merchant: @merchant)
    @invoice_3 = create(:invoice, customer: @customer_3, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item, item: @item, invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, item: @item, invoice: @invoice_2)
    @invoice_item_3 = create(:invoice_item, item: @item, invoice: @invoice_3)
  end

  describe 'when I send a request to the items-invoice_items endpoint' do
    before(:each) do
      get "/api/v1/items/#{@item.id}/invoice_items"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all invoice_items associated with item' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].class).to eq(Array)
      expect(@json['data'].length).to eq(3)

      expected = [@invoice_item_1, @invoice_item_2, @invoice_item_3]
      @json['data'].each_with_index do |item, index|
        expect(item['id']).to eq(expected[index].id.to_s)
        expect(item['type']).to eq('invoice_item')

        attributes = item['attributes']

        formatted_price = sprintf('%.2f', expected[index].unit_price / 100.0)
        expect(attributes['id']).to eq(expected[index].id)
        expect(attributes['item_id']).to eq(expected[index].item_id)
        expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
        expect(attributes['quantity']).to eq(expected[index].quantity)
        expect(attributes['unit_price']).to eq(formatted_price)
      end
    end
  end
end
