# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    created_at { Time.zone.parse(Faker::Date.in_date_period.to_s) }
    updated_at { Time.zone.parse(Faker::Date.in_date_period.to_s) }
  end
end
