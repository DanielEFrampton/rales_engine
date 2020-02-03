# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
    @transaction_1 = create(:transaction, invoice: @invoice)
    @transaction_2 = create(:transaction, invoice: @invoice, result: 'failed')
    @transaction_3 = create(:transaction, invoice: @invoice, result: 'failed')
  end

  describe 'when I send a get request to the transactions index path' do
    before(:each) do
      get "/api/v1/transactions/"
      @json = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing all transaction records' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].class).to eq(Array)
      expect(@json['data'].length).to eq(3)

      expected = [@transaction_1, @transaction_2, @transaction_3]
      @json['data'].each_with_index do |transaction, index|
        expect(transaction['id']).to eq(expected[index].id.to_s)
        expect(transaction['type']).to eq('transaction')

        attributes = transaction['attributes']

        expect(attributes['id']).to eq(expected[index].id)
        expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
        expect(attributes['result']).to eq(expected[index].result)
        expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
      end
    end
  end
end
