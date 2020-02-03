class Api::V1::InvoiceItems::InvoiceItemsController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all)
  end
end
