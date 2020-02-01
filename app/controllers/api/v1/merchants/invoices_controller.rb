class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    invoices = Merchant.find(params[:merchant_id]).invoices.order(:id)
    render json: InvoiceSerializer.new(invoices)
  end
end
