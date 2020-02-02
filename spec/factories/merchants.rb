# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
    created_at { Time.zone.parse(Faker::Date.unique.in_date_period.to_s) }
    updated_at { Time.zone.parse(Faker::Date.unique.in_date_period.to_s) }
  end
end
