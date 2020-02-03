# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
    @transaction = create(:transaction, invoice: @invoice)
  end

  describe 'when I send a get request to the transactions show path' do
    before(:each) do
      get "/api/v1/transactions/#{@transaction.id}"
      @json = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of transaction' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)

      expect(@json['data']['id']).to eq(@transaction.id.to_s)
      expect(@json['data']['type']).to eq('transaction')

      attributes = @json['data']['attributes']

      expect(attributes['id']).to eq(@transaction.id)
      expect(attributes['invoice_id']).to eq(@transaction.invoice_id)
      expect(attributes['result']).to eq(@transaction.result)
      expect(attributes['credit_card_number']).to eq(@transaction.credit_card_number)
    end
  end
end
