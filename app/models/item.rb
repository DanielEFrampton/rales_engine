# frozen_string_literal: true

# Items sold by Merchants
class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    joins(invoices: :transactions)
      .select('items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
      .group(:id)
      .where(transactions: { result: 'success'} )
      .order('total_revenue DESC')
      .limit(quantity)
  end
end
