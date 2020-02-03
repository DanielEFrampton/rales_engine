require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
    @transaction_1 = create(:transaction, invoice: @invoice)
    @transaction_2 = create(:transaction, invoice: @invoice)
    @transaction_3 = create(:transaction, invoice: @invoice)
  end

  describe 'when I send a request to the invoices/:id/transactions path' do
    before(:each) do
      get "/api/v1/invoices/#{@invoice.id}/transactions"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all transactions associated with invoice' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].class).to eq(Array)
      expect(@json['data'].length).to eq(3)

      exp = [@transaction_1, @transaction_2, @transaction_3]
      @json['data'].each_with_index do |item, index|
        expect(item['id']).to eq(exp[index].id.to_s)
        expect(item['type']).to eq('transaction')

        atts = item['attributes']

        expect(atts['id']).to eq(exp[index].id)
        expect(atts['invoice_id']).to eq(exp[index].invoice_id)
        expect(atts['credit_card_number']).to eq(exp[index].credit_card_number)
        expect(atts['result']).to eq(exp[index].result)
      end
    end
  end
end
