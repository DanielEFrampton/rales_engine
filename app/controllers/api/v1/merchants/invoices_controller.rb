class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    invoices = Merchant.find(params[:merchant_id]).invoices
    render json: InvoiceSerializer.new(invoices)
  end
end
