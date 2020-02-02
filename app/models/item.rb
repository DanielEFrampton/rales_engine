# frozen_string_literal: true

# Items sold by Merchants
class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.best_day(item_id)
    joins(invoices: :transactions)
      .select("date_trunc('day', invoices.created_at) AS date")
      .where(transactions: { result: 'success'} )
      .where(id: item_id)
      .order('sum(invoice_items.quantity) DESC, date DESC')
      .group("date_trunc('day', invoices.created_at)")
      .limit(1)
      .first.date
  end

  def self.most_revenue(quantity)
    joins(invoices: :transactions)
      .select('items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')
      .group(:id)
      .where(transactions: { result: 'success'} )
      .order('total_revenue DESC')
      .limit(quantity)
  end
end
