# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_item do
    item
    invoice { nil }
    quantity { rand(1..10) }
    unit_price { rand(100..50000) }
  end
end
