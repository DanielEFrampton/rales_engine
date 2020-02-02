class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Invoice.revenue(params[:date])
    render json: RevenueSerializer.new(revenue, params[:date])
  end
end
