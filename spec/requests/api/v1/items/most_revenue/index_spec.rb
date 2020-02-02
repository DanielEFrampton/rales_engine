require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)

    @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer)
    @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer)

    @item_1 = create(:item, merchant: @merchant)  # #4, revenue: 6.00
    @item_2 = create(:item, merchant: @merchant)  # #2, revenue: 9.00
    @item_3 = create(:item, merchant: @merchant)  # #1, revenue: 10.00
    @item_4 = create(:item, merchant: @merchant)  # #3, revenue: 8.00

    @invoice_item_1 = create(:invoice_item,
                              invoice: @invoice_1,
                              item: @item_1,
                              quantity: 1,
                              unit_price: 600)
    @invoice_item_2 = create(:invoice_item,
                              invoice: @invoice_1,
                              item: @item_3,
                              quantity: 2,
                              unit_price: 200)

    @invoice_item_3 = create(:invoice_item,
                              invoice: @invoice_2,
                              item: @item_3,
                              quantity: 3,
                              unit_price: 200)
    @invoice_item_4 = create(:invoice_item,
                              invoice: @invoice_2,
                              item: @item_2,
                              quantity: 1,
                              unit_price: 900)
    @invoice_item_5 = create(:invoice_item,
                              invoice: @invoice_2,
                              item: @item_4,
                              quantity: 2,
                              unit_price: 400)

  end

  describe 'when I send a request to the items/most_revenue endpoint' do
    describe 'with a valid quantity x' do
      before(:each) do
        get "/api/v1/items/most_revenue?quantity=3"
        @json = JSON.parse(response.body)
      end

      it 'I get JSON data for x items with most revenue generated' do
        expect(@json.class).to eq(Hash)
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(3)

        expected = [@item_3, @item_2, @item_4]
        item_data = @hash['data']
        item_data.each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('item')

          attributes = item['attributes']

          expect(attributes['name']).to eq(expected[index].name)
          expect(attributes['description']).to eq(expected[index].description)
          expect(attributes['unit_price']).to eq(expected[index].unit_price)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end
  end
end
