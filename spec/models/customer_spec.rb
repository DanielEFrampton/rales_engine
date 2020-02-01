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

          expect(Customer.favorite_customer(@merchant.id)).to eq(@customer_2)
        end
      end
    end
  end
end
