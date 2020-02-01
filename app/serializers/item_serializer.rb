# frozen_string_literal: true

# FastJsonapi Serializer for Item model
class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id
end
