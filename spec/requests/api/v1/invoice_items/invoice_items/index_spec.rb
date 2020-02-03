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
  end

  describe 'when I send a request to the invoice_items index endpoint' do
    before(:each) do
      get "/api/v1/invoice_items/"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all invoice_items' do
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
