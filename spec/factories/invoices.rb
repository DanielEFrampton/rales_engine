# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    status { "MyText" }
    customer { nil }
    merchant { nil }
  end
end
