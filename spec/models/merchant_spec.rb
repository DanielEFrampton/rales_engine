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
      describe 'case_insensitive_name_find' do
        it 'returns single record with matching name regardless of case' do
          @merchant_1 = create(:merchant, name: 'Patrick McKelly')
          @merchant_2 = create(:merchant)

          found = Merchant.case_insensitive_name_find('patrIck mckeLly')
          expect(found).to eq(@merchant_1)
        end
      end

      describe 'case_insensitive_name_find_all' do
        it 'returns all records with matching name regardless of case' do
          @merchant_1 = create(:merchant, name: 'Patrick McKelly')
          @merchant_2 = create(:merchant)
          @merchant_3 = create(:merchant)
          @merchant_4 = create(:merchant, name: 'Patrick McKelly')

          found = Merchant.case_insensitive_name_find_all('patrIck mckeLly')
          expect(found).to eq([@merchant_1, @merchant_4])
        end
      end
    end
  end
end
