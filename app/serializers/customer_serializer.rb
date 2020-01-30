# frozen_string_literal: true

# FastJsonapi Serializer for Customer model
class CustomerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :first_name, :last_name
end
