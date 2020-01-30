# frozen_string_literal: true

# Controller for Random Merchant endpoint
class Api::V1::Merchants::RandomController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.random)
  end
end
