# frozen_string_literal: true

# Controller for Find Single Merchant Endpoint
class Api::V1::Merchants::FindController < ApplicationController
  def show
    if parameters[:name]
      merchant = Merchant.ci_name_find(parameters[:name])
    else
      merchant = Merchant.find_by(parameters)
    end
    render json: MerchantSerializer.new(merchant)
  end

  def index
    if parameters[:name]
      merchants = Merchant.ci_name_find_all(parameters[:name])
    else
      merchants = Merchant.where(parameters)
    end
    render json: MerchantSerializer.new(merchants)
  end

  private

  def parameters
    params.permit(:name, :id, :created_at, :updated_at)
  end
end
