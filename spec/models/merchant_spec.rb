# frozen_string_literal: true

require 'rails_helper'

# Merchant who sells Items to Customers
RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'methods' do
  end
end
