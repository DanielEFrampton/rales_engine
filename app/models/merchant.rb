# frozen_string_literal: true

# Merchant who sells Items to Customers
class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices

  def self.ci_name_find(name)
    where('LOWER(merchants.name) = LOWER(?)', name).first
  end

  def self.ci_name_find_all(name)
    where('LOWER(merchants.name) = LOWER(?)', name)
  end
end
