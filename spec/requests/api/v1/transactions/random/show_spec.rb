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
    @ids = [@transaction_1.id, @transaction_2.id, @transaction_3.id]
    @ccns = [@transaction_1.credit_card_number,
             @transaction_2.credit_card_number,
             @transaction_3.credit_card_number]
    @invoice_ids = [@transaction_1.invoice_id,
                    @transaction_2.invoice_id,
                    @transaction_3.invoice_id]
    @results = [@transaction_1.result,
                @transaction_2.result,
                @transaction_3.result]
  end

  describe 'when I send a get request to the transactions random path' do
    before(:each) do
      get '/api/v1/transactions/random'
      @json = JSON.parse(response.body)
    end

    it 'I getJSON:API data for a random transaction record' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)
      expect(@json['data'].class).to eq(Hash)

      expect(@ids).to include(@json['data']['id'].to_i)
      expect(@json['data']['type']).to eq('transaction')

      attributes = @json['data']['attributes']
      expect(attributes.class).to eq(Hash)
      expect(attributes.length).to eq(4)

      expect(@results).to include(attributes['result'])
      expect(@ccns).to include(attributes['credit_card_number'])
      expect(@invoice_ids).to include(attributes['invoice_id'])
      expect(@ids).to include(attributes['id'])
    end
  end
end
