require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  describe 'when I send a get request to the "merchant/:id/invoices" path' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @invoice_1 = create(:invoice, merchant: @merchant_1)
      @invoice_2 = create(:invoice, merchant: @merchant_1)
      @invoice_3 = create(:invoice, merchant: @merchant_1)
      @invoice_4 = create(:invoice, merchant: @merchant_2)
      @invoice_5 = create(:invoice, merchant: @merchant_2)

      @invoices = [@invoice_1, @invoice_2, @invoice_3]

      get "/api/v1/merchants/#{@merchant_1.id}/invoices"
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response with all invoices associated with merchant' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)

      invoices = @hash['data']
      invoices.each_with_index do |invoice, index|
        expect(invoice['id']).to eq(@invoices[index].id.to_s)
        expect(invoice['type']).to eq('invoice')

        attributes = invoice['attributes']

        expect(attributes['id']).to eq(@invoices[index].id)
        expect(attributes['customer_id']).to eq(@invoices[index].customer_id)
        expect(attributes['status']).to eq(@invoices[index].status)
        expect(attributes['merchant_id']).to eq(@invoices[index].merchant_id)
      end
    end
  end
end
