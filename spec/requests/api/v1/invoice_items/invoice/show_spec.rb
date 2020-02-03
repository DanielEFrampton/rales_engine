require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
    @item = create(:item, merchant: @merchant)
    @invoice_item = create(:invoice_item, item: @item, invoice: @invoice)
  end

  describe 'when I send a request to the invoice_item-invoice endpoint' do
    before(:each) do
      get "/api/v1/invoice_items/#{@invoice_item.id}/invoice"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for the invoice associated with invoice_item' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)

      expect(@json['data']['id']).to eq(@invoice.id.to_s)
      expect(@json['data']['type']).to eq('invoice')

      attributes = @json['data']['attributes']

      expect(attributes['id']).to eq(@invoice.id)
      expect(attributes['customer_id']).to eq(@invoice.customer_id)
      expect(attributes['status']).to eq(@invoice.status)
      expect(attributes['merchant_id']).to eq(@invoice.merchant_id)
    end
  end
end
