# frozen_string_literal: true

require 'rails_helper'

# Merchant model test
RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'methods' do
    describe 'class methods' do
      describe 'favorite_merchant' do
        it 'returns merchant customer has most successful transactions with' do
          @customer_1 = create(:customer)
          @merchant_1 = create(:merchant)
          @merchant_2 = create(:merchant)
          @merchant_3 = create(:merchant)

          1.times do
            invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant_1)
            item_1 = create(:item, merchant: @merchant_1)
            create(:invoice_item, item: item_1, invoice: invoice_1)
            create(:transaction, invoice: invoice_1)

            invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant_1)
            item_2 = create(:item, merchant: @merchant_1)
            create(:invoice_item, item: item_2, invoice: invoice_2)
            create(:transaction, invoice: invoice_2, result: 'failed')
          end

          3.times do
            invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant_2)
            item_1 = create(:item, merchant: @merchant_2)
            create(:invoice_item, item: item_1, invoice: invoice_1)
            create(:transaction, invoice: invoice_1)

            invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant_2)
            item_2 = create(:item, merchant: @merchant_2)
            create(:invoice_item, item: item_2, invoice: invoice_2)
            create(:transaction, invoice: invoice_2, result: 'failed')
          end

          2.times do
            invoice_1 = create(:invoice, customer: @customer_1, merchant: @merchant_3)
            item_1 = create(:item, merchant: @merchant_3)
            create(:invoice_item, item: item_1, invoice: invoice_1)
            create(:transaction, invoice: invoice_1)

            invoice_2 = create(:invoice, customer: @customer_1, merchant: @merchant_3)
            item_2 = create(:item, merchant: @merchant_3)
            create(:invoice_item, item: item_2, invoice: invoice_2)
            create(:transaction, invoice: invoice_1, result: 'failed')
          end

          expect(Merchant.favorite_merchant(@customer_1.id)).to eq(@merchant_2)
        end
      end

      describe 'most_revenue' do
        it 'returns x merchants sorted by most revenue' do
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

          expected_top_3 = [@merchant_5, @merchant_6, @merchant_2]

          all_ordered = [@merchant_5, @merchant_6, @merchant_2,
                        @merchant_4, @merchant_1, @merchant_3]

          expect(Merchant.most_revenue(3)).to eq(expected_top_3)
          expect(Merchant.most_revenue(1)).to eq([@merchant_5])
          expect(Merchant.most_revenue(-1)).to eq([])
          expect(Merchant.most_revenue(0)).to eq([])
          expect(Merchant.most_revenue(7)).to eq(all_ordered)
        end
      end

      describe 'ci_name_find' do
        it 'returns single record with matching name regardless of case' do
          @merchant_1 = create(:merchant, name: 'Patrick McKelly')
          @merchant_2 = create(:merchant)

          found = Merchant.ci_name_find('patrIck mckeLly')
          expect(found).to eq(@merchant_1)
        end
      end

      describe 'ci_name_find_all' do
        it 'returns all records with matching name regardless of case' do
          @merchant_1 = create(:merchant, name: 'Patrick McKelly')
          @merchant_2 = create(:merchant)
          @merchant_3 = create(:merchant)
          @merchant_4 = create(:merchant, name: 'Patrick McKelly')

          found = Merchant.ci_name_find_all('patrIck mckeLly')
          expect(found).to eq([@merchant_1, @merchant_4])
        end
      end
    end
  end
end
