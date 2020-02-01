# frozen_string_literal: true

# Controller for Random Merchant endpoint
class Api::V1::Customers::RandomController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.random)
  end
end
