class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    favorite_customer = Customer.favorite_customer(params[:merchant_id])
    render json: CustomerSerializer.new(favorite_customer)
  end
end
