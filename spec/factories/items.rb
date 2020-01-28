# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    name { 'MyText' }
    description { 'MyText' }
    unit_price { 1 }
    merchant { nil }
  end
end
