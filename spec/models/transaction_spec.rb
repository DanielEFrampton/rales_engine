# frozen_string_literal: true

require 'rails_helper'

# Transaction model test
RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of :credit_card_number }
    it { should validate_presence_of :result }
  end

  describe 'relationships' do
    it { should belong_to :invoice}
  end

  describe 'methods' do
  end
end
