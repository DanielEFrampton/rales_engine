require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)

    @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer)
    @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer)
    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)

    @invoice_item_1 = create(:invoice_item,
                              invoice: @invoice_1,
                              item: @item_1,
                              quantity: 3,
                              unit_price: 100,
                              created_at: '2012-03-12')
    @invoice_item_2 = create(:invoice_item,
                              invoice: @invoice_1,
                              item: @item_2,
                              quantity: 2,
                              unit_price: 500,
                              created_at: '2012-03-12')
    @invoice_item_3 = create(:invoice_item,
                              invoice: @invoice_1,
                              item: @item_3,
                              quantity: 4,
                              unit_price: 200,
                              created_at: '2012-03-12')
    @invoice_item_4 = create(:invoice_item,
                              invoice: @invoice_1,
                              item: @item_4,
                              quantity: 2,
                              unit_price: 600,
                              created_at: '2012-03-12')

    @invoice_item_5 = create(:invoice_item,
                              invoice: @invoice_2,
                              item: @item_1,
                              quantity: 2,
                              unit_price: 300,
                              created_at: '2012-03-23')
    @invoice_item_6 = create(:invoice_item,
                              invoice: @invoice_2,
                              item: @item_2,
                              quantity: 1,
                              unit_price: 600,
                              created_at: '2012-03-23')
    @invoice_item_7 = create(:invoice_item,
                              invoice: @invoice_2,
                              item: @item_3,
                              quantity: 2,
                              unit_price: 300,
                              created_at: '2012-03-23')
    @invoice_item_8 = create(:invoice_item,
                              invoice: @invoice_2,
                              item: @item_4,
                              quantity: 1,
                              unit_price: 1100,
                              created_at: '2012-03-23')

  end

  describe 'when I send a request to the items/:id/best_day endpoint' do
    it 'returns the date in YYYY-MM-DD format with most revenue for item' do
      get "/api/v1/items/#{@item_1.id}/best_day"
      json_1 = JSON.parse(response.body)

      expect(json_1.class).to eq(Hash)
      expect(json_1.length).to eq(1)
      expect(json_1['data'].class).to eq(Hash)
      expect(json_1['data'].length).to eq(1)

      expect(json_1['data']['attributes']['best_day']).to eq('2012-03-23')

      get "/api/v1/items/#{@item_2.id}/best_day"
      json_2 = JSON.parse(response.body)

      expect(json_2['data']['attributes']['best_day']).to eq('2012-03-12')

      get "/api/v1/items/#{@item_3.id}/best_day"
      json_3 = JSON.parse(response.body)

      expect(json_3['data']['attributes']['best_day']).to eq('2012-03-23')

      get "/api/v1/items/#{@item_4.id}/best_day"
      json_4 = JSON.parse(response.body)

      expect(json_4['data']['attributes']['best_day']).to eq('2012-03-12')
    end
  end
end
