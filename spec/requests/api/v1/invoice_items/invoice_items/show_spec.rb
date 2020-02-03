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

  describe 'when I send a request to the invoice_items show path' do
    before(:each) do
      get "/api/v1/invoice_items/#{@invoice_item_1.id}/"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data with attributes of invoice_item record' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].class).to eq(Hash)
      expect(@json['data'].length).to eq(3)

      expect(@json['data']['id']).to eq(@invoice_item_1.id.to_s)
      expect(@json['data']['type']).to eq('invoice_item')

      attributes = @json['data']['attributes']
      formatted_price = sprintf('%.2f', @invoice_item_1.unit_price / 100.0)

      expect(attributes['id']).to eq(@invoice_item_1.id)
      expect(attributes['item_id']).to eq(@invoice_item_1.item_id)
      expect(attributes['invoice_id']).to eq(@invoice_item_1.invoice_id)
      expect(attributes['quantity']).to eq(@invoice_item_1.quantity)
      expect(attributes['unit_price']).to eq(formatted_price)
    end
  end
end
