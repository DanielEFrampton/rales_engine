# frozen_string_literal: true

# FastJsonapi Serializer for Invoice model
class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :status, :customer_id, :merchant_id
end
