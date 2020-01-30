# frozen_string_literal: true

# Controller for Find Single Merchant Endpoint
class Api::V1::Merchants::FindController < ApplicationController
  def show
    if parameters[:name]
      render json: MerchantSerializer.new(Merchant.ci_name_find(parameters[:name]))
    else
      render json: MerchantSerializer.new(Merchant.find_by(parameters))
    end
  end

  def index
    if parameters[:name]
      render json: MerchantSerializer.new(Merchant.ci_name_find_all(parameters[:name]))
    else
      render json: MerchantSerializer.new(Merchant.where(parameters))
    end
  end

  private

  def parameters
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
