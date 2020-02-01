class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    favorite_customer = Merchant.find(params[:merchant_id]).favorite_customer
    render json: CustomerSerializer.new(favorite_customer)
  end
end
