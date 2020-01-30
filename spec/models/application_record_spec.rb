require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe 'class methods' do
    before(:each) do
      @customer_1 = create(:customer, first_name: 'John')
      @customer_2 = create(:customer)
      @customer_3 = create(:customer, first_name: 'John')
      @customer_4 = create(:customer, last_name: "De'Angelo")
    end

    describe 'ci_find' do
      it 'returns the first record with case-insensitive value for attribute' do
        upcase = @customer_1.first_name.upcase
        downcase = @customer_1.first_name.downcase

        expect(Customer.ci_find('first_name', upcase)).to eq(@customer_1)
        expect(Customer.ci_find('first_name', downcase)).to eq(@customer_1)
        expect(Customer.ci_find('last_name', "De'Angelo")).to eq(@customer_4)
      end
    end

    describe 'ci_find_all' do
      it 'returns alls record with case-insensitive value for attribute' do
        upcase = @customer_1.first_name.upcase
        downcase = @customer_1.first_name.downcase

        found_records_1 = Customer.ci_find_all('first_name', upcase)
        expect(found_records_1).to eq([@customer_1, @customer_3])

        found_records_2 = Customer.ci_find_all('first_name', downcase)
        expect(found_records_2).to eq([@customer_1, @customer_3])

        found_records_3 = Customer.ci_find_all('last_name', "De'Angelo")
        expect(found_records_3).to eq([@customer_4])
      end
    end
  end
end
