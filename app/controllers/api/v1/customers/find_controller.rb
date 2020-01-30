# frozen_string_literal: true

# Controller for Find Single Customer Endpoint
class Api::V1::Customers::FindController < ApplicationController
  def show
    render json: CustomerSerializer.new(found_records(:find_by))
  end

  def index
    render json: CustomerSerializer.new(found_records(:where))
  end

  private

  def parameters
    params.permit(:first_name, :last_name, :id, :created_at, :updated_at)
  end

  def attribute
    parameters.keys.first
  end

  def value
    parameters.values.first
  end

  def found_records(method)
    if ["first_name", "last_name"].include?(attribute)
      Customer.ci_find(attribute, value)
    else
      Customer.send(method, attribute => value)
    end
  end
end
