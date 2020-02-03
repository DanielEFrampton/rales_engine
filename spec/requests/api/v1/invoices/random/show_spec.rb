# frozen_string_literal: true

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
    @ids = [@invoice_1.id, @invoice_2.id, @invoice_3.id]
    @statuses = [@invoice_1.status, @invoice_2.status, @invoice_3.status]
    @merchant_ids = [@invoice_1.merchant_id,
                    @invoice_2.merchant_id,
                    @invoice_3.merchant_id]
    @customer_ids = [@invoice_1.customer_id,
                    @invoice_2.customer_id,
                    @invoice_3.customer_id]
  end

  describe 'when I send a get request to the invoices random path' do
    before(:each) do
      get '/api/v1/invoices/random'
      @json = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of a random invoice' do
      expect(@json.class).to eq(Hash)
      expect(@json.keys).to eq(['data'])
      expect(@json['data'].length).to eq(3)
      expect(@json['data'].class).to eq(Hash)

      expect(@ids).to include(@json['data']['id'].to_i)
      expect(@json['data']['type']).to eq('invoice')

      attributes = @json['data']['attributes']
      expect(attributes.class).to eq(Hash)
      expect(attributes.length).to eq(4)
      expect(@statuses).to include(attributes['status'])
      expect(@merchant_ids).to include(attributes['merchant_id'])
      expect(@customer_ids).to include(attributes['customer_id'])
      expect(@ids).to include(attributes['id'])
    end
  end
end
