# frozen_string_literal: true

require 'rails_helper'

# Customer model test
RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'methods' do
    describe 'class methods' do
      describe 'favorite_customer' do
        it 'returns customer with most successful transactions with merchant' do
          @merchant = create(:merchant)
          @merchant_2 = create(:merchant)

          @customer_1 = create(:customer)
          @customer_2 = create(:customer)
          @customer_3 = create(:customer)
          @customer_4 = create(:customer)
          @customer_5 = create(:customer)
          @customer_6 = create(:customer)

          @invoice_1 = create(:invoice, merchant: @merchant, customer: @customer_1)
          @transaction_1 = create(:transaction, invoice: @invoice_1)
          @invoice_2 = create(:invoice, merchant: @merchant, customer: @customer_1)
          @transaction_2 = create(:transaction, invoice: @invoice_2, result: 'failed')

          @invoice_3 = create(:invoice, merchant: @merchant, customer: @customer_2)
          @transaction_3 = create(:transaction, invoice: @invoice_3)
          @invoice_4 = create(:invoice, merchant: @merchant, customer: @customer_2)
          @transaction_4 = create(:transaction, invoice: @invoice_4)
          @invoice_5 = create(:invoice, merchant: @merchant, customer: @customer_2)
          @transaction_5 = create(:transaction, invoice: @invoice_5, result: 'failed')

          @invoice_6 = create(:invoice, merchant: @merchant, customer: @customer_3)
          @transaction_6 = create(:transaction, invoice: @invoice_6)

          @invoice_7 = create(:invoice, merchant: @merchant_2, customer: @customer_4)
          @transaction_7 = create(:transaction, invoice: @invoice_7)
          @invoice_8 = create(:invoice, merchant: @merchant_2, customer: @customer_4)
          @transaction_8 = create(:transaction, invoice: @invoice_8, result: 'failed')

          @invoice_9 = create(:invoice, merchant: @merchant_2, customer: @customer_5)
          @transaction_9 = create(:transaction, invoice: @invoice_9)
          @invoice_10 = create(:invoice, merchant: @merchant_2, customer: @customer_5)
          @transaction_10 = create(:transaction, invoice: @invoice_10)
          @invoice_11 = create(:invoice, merchant: @merchant_2, customer: @customer_5)
          @transaction_11 = create(:transaction, invoice: @invoice_11, result: 'failed')

          @invoice_12 = create(:invoice, merchant: @merchant_2, customer: @customer_6)
          @transaction_12 = create(:transaction, invoice: @invoice_12)

          expect(Customer.favorite_customer(@merchant.id)).to eq(@customer_2)
          expect(Customer.favorite_customer(@merchant_2.id)).to eq(@customer_5)
        end
      end
    end
  end
end
