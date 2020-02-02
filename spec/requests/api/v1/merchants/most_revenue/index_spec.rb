require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
    @merchant_6 = create(:merchant)

    @merchants = [@merchant_1,
                  @merchant_2,
                  @merchant_3,
                  @merchant_4,
                  @merchant_5,
                  @merchant_6]

    values = [2,4,1,3,6,5]

    @merchants.each_with_index do |merchant, index|
      10.times do
        invoice = create(:invoice, merchant: merchant)
        create(:transaction, invoice: invoice)
        item = create(:item, merchant: merchant)
        create(:invoice_item,
                invoice: invoice,
                item: item,
                quantity: values[index],
                unit_price: values[index])
      end
    end
  end

  describe 'when I send a request to the merchants most revenue route' do
    describe 'and I provide 3 as the quantity' do
      before(:each) do
        get "/api/v1/merchants/most_revenue?quantity=3"
        @hash = JSON.parse(response.body)
      end

      it 'I receive JSON data for 3 merchants with most revenue' do

      end
    end
  end
end


# total revenue =
#   quantity * unit price on invoice_items
#   where transactions.result = 'success'
#   joins merchants, invoices, transactions, invoice_items
#   select merchants.*, sum(quantity * unit price on invoice_items) AS total_r
#   group by merchants.id
#   order by total_r
#   limit by quantity
