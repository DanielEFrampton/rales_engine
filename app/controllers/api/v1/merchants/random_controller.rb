# frozen_string_literal: true

# Controller for Random Merchant endpoint
class Api::V1::Merchants::RandomController < ApplicationController
  def show
    ids = Merchant.all.pluck(:id)
    random_id = ids.sample
    render json: MerchantSerializer.new(Merchant.find(random_id))
  end
end
