# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Movies::Hobbit.quote }
    unit_price { rand(100..50000) }
    merchant { nil }
  end
end
