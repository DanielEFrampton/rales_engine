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
    describe 'instance methods' do
      describe 'favorite_customer' do
        it 'returns customer with most successful transactions with merchant' do
          @merchant = create(:merchant)

          @customer_1 = create(:customer)
          @customer_2 = create(:customer)
          @customer_3 = create(:customer)

          @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1)
          @transaction_1 = create(:transaction, invoice: @invoice_1)
          @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1)
          @transaction_1 = create(:transaction, invoice: @invoice_2)

          @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2)
          @transaction_1 = create(:transaction, invoice: @invoice_3)
          @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2)
          @transaction_1 = create(:transaction, invoice: @invoice_4)
          @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_2)
          @transaction_1 = create(:transaction, invoice: @invoice_5)

          @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_3)
          @transaction_1 = create(:transaction, invoice: @invoice_6)

          expect(@merchant.favorite_customer).to eq(@customer_2)
        end
      end
    end

    describe 'class methods' do
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
