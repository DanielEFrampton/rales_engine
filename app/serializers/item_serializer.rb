# frozen_string_literal: true

# FastJsonapi Serializer for Item model
class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :merchant_id

  attribute :unit_price do |object|
    sprintf('%.2f', object.unit_price / 100.0)
  end
end
