# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    invoice { nil }
    credit_card_number { 1 }
    credit_card_expiration_date { nil }
    result { 'MyText' }
  end
end
