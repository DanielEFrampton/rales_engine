# frozen_string_literal: true

# Controller for Merchants resource in API/V1 namespace
class Api::V1::Merchants::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end
end
