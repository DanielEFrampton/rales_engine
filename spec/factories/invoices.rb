FactoryBot.define do
  factory :invoice do
    status { "MyText" }
    customer { nil }
    merchant { nil }
  end
end
