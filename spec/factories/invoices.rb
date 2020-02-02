# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    status { 'shipped' }
    customer
    merchant { nil }
  end
end
