# frozen_string_literal: true

# Confirmation of interaction betwen Merchant and Customer
class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.total_revenue_on_date(date)
    total_revenue = joins(:invoice_items, :transactions)
      .where(created_at: (date + ' 00:00:00')..(date + ' 23:59:59'))
      .where(transactions: { result: 'success' })
      .sum('invoice_items.quantity * invoice_items.unit_price')
    total_revenue / 100.0
  end
end
