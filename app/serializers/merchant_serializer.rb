# frozen_string_literal: tru

# FastJsonapi Serializer for Merchant model
class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
end
