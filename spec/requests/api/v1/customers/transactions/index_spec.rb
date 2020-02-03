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
    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)
  end

  describe 'when I send a request to the customers-transactions endpoint' do
    before(:each) do
      get "/api/v1/customers/#{@customer.id}/transactions"
      @json = JSON.parse(response.body)
    end

    it 'I get JSON data for all transactions associated with customer' do
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
