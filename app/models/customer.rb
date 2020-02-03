# frozen_string_literal: true

# Customers who buy Items from Merchants
class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.favorite_customer(merchant_id)
    select('customers.*, count(transactions.id) AS total_transactions')
      .joins(invoices: :transactions)
      .where(transactions: { result: 'success' } )
      .where(invoices: { merchant_id: merchant_id })
      .order('total_transactions DESC')
      .group(:id)
      .limit(1)
      .first
  end
end
