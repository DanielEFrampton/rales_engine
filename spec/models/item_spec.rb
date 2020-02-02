# frozen_string_literal: true

require 'rails_helper'

# Item model test
RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'methods' do
    describe 'class methods' do
      describe 'most_revenue' do
        it 'returns x number of items with most revenue generated' do
          @merchant = create(:merchant)
          @customer = create(:customer)

          @invoice_1 = create(:invoice,
                              merchant: @merchant,
                              customer: @customer)
          @invoice_2 = create(:invoice,
                              merchant: @merchant,
                              customer: @customer)
          @transaction_1 = create(:transaction, invoice: @invoice_1)
          @transaction_2 = create(:transaction, invoice: @invoice_2)

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

          expect(Item.most_revenue(3)).to eq([@item_3, @item_2, @item_4])
          expect(Item.most_revenue(5)).to eq([@item_3,
                                              @item_2,
                                              @item_4,
                                              @item_1])
          expect(Item.most_revenue(0)).to eq([])
        end
      end
    end
  end
end
