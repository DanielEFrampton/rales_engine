# frozen_string_literal: true

# Joins table between Invoice and Item models
class InvoiceItem < ApplicationRecord
  validates_presence_of :quantity, :unit_price

  belongs_to :item
  belongs_to :invoice

  def unit_price_decimal
    unit_price / 100.0
  end
end
