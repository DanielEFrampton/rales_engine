# frozen_string_literal: tru

# FastJsonapi Serializer for Merchant model
class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :result, :credit_card_number, :invoice_id
end
