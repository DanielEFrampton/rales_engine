class Api::V1::Invoices::InvoicesController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end

  def index
    render json: InvoiceSerializer.new(Invoice.all)
  end
end
