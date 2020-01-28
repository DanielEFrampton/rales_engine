# Customers who buy Items from Merchants
class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices
end
