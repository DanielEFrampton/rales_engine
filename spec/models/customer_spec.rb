# frozen_string_literal: true

require 'rails_helper'

# Customers
RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'methods' do
  end
end
