require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
  end

  describe 'when I send a request to the invoices/:id/customer path' do
    before(:each) do
      get "/api/v1/invoices/#{@invoice.id}/customer"
      @hash = JSON.parse(response.body)
    end

    it 'I get JSON data for the customer associated with invoice' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)
      expect(@hash['data'].class).to eq(Hash)
      expect(@hash['data']['id']).to eq(@customer.id.to_s)
      expect(@hash['data']['type']).to eq('customer')

      attributes = @hash['data']['attributes']
      expect(attributes.class).to eq(Hash)
      expect(attributes.length).to eq(3)
      expect(attributes['first_name']).to eq(@customer.first_name.to_s)
      expect(attributes['last_name']).to eq(@customer.last_name.to_s)
      expect(attributes['id']).to eq(@customer.id)
    end
  end
end
