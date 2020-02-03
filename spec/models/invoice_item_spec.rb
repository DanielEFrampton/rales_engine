# frozen_string_literal: true

require 'rails_helper'

# InvoiceItem model test
RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe 'methods' do
    describe 'instance methods' do
      describe 'unit_price_decimal' do
        it 'returns unit_price as float with two decimal places' do
          @merchant = create(:merchant)
          @customer = create(:customer)
          @item = create(:item, unit_price: 12345, merchant: @merchant)
          @invoice = create(:invoice, customer: @customer, merchant: @merchant)
          @invoice_item = create(:invoice_item,
                                  invoice: @invoice,
                                  item: @item,
                                  unit_price: 12345)

          expect(@invoice_item.unit_price_decimal).to eq(123.45)
        end
      end
    end
  end
end
