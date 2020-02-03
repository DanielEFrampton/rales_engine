require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer = create(:customer)
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @invoice_1 = create(:invoice, customer: @customer, merchant: @merchant_1)
    @invoice_2 = create(:invoice, customer: @customer, merchant: @merchant_2)
    @invoice_3 = create(:invoice, customer: @customer, merchant: @merchant_3)
    @invoices = [@invoice_1, @invoice_2, @invoice_3]
  end

  describe 'when I send a request to the invoices index endpoint' do
    before(:each) do
      get "/api/v1/invoices/"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all invoices' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)

      invoices = @json['data']
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
