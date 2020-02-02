# frozen_string_literal: true

require 'rails_helper'

# Invoice model test
RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'methods' do
    describe 'class methods' do
      describe 'total_revenue_on_date' do
        it 'returns total revenue on date as float with two decimals' do
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

          # 6 x 10 x 100 = $60.00 revenue
          @merchants.each_with_index do |merchant, index|
            10.times do
              invoice = create(:invoice, merchant: merchant, created_at: '2012-03-16')
              create(:transaction, invoice: invoice)
              item = create(:item, merchant: merchant)
              create(:invoice_item,
                      invoice: invoice,
                      item: item,
                      quantity: 1,
                      unit_price: 100)
            end
          end

          # 6 x 5 x 100 = $30.00 revenue
          @merchants.each_with_index do |merchant, index|
            5.times do
              invoice = create(:invoice, merchant: merchant, created_at: '2012-03-07')
              create(:transaction, invoice: invoice)
              item = create(:item, merchant: merchant)
              create(:invoice_item,
                      invoice: invoice,
                      item: item,
                      quantity: 1,
                      unit_price: 100)
            end
          end

          expect(Invoice.total_revenue_on_date('2012-03-16')).to eq(60.00)
          expect(Invoice.total_revenue_on_date('2012-03-07')).to eq(30.00)
          expect(Invoice.total_revenue_on_date('2012-05-23')).to eq(0.00)
        end
      end
    end
  end
end
