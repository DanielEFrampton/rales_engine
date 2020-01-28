# frozen_string_literal: true

# Record of credit-card charge associated with an Invoice
class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :result

  belongs_to :invoice
end
