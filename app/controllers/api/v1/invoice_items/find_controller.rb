# frozen_string_literal: true

# Controller for Find Single Invoice Endpoint
class Api::V1::InvoiceItems::FindController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(found_records(:find_by))
  end

  def index
    render json: InvoiceItemSerializer.new(found_records(:where))
  end

  private

  def parameters
    params.permit(:id,
                  :created_at,
                  :updated_at,
                  :invoice_id,
                  :item_id,
                  :quantity,
                  :unit_price)
  end

  def attribute
    parameters.keys.first
  end

  def value
    parameters.values.first
  end

  def found_records(search_method)
    if attribute == 'unit_price'
      formatted_value = value.delete('.').to_i
      InvoiceItem.send(search_method, attribute => formatted_value)
    else
      InvoiceItem.send(search_method, attribute => value)
    end
  end
end
