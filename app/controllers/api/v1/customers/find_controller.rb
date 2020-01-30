# frozen_string_literal: true

# Controller for Find Single Customer Endpoint
class Api::V1::Customers::FindController < ApplicationController
  def show
    if ["first_name", "last_name"].include?(attribute)
      customer = Customer.ci_find(attribute, value)
    else
      customer = Customer.find_by(attribute => value)
    end
    render json: CustomerSerializer.new(customer)
  end

  def index
    customers = if parameters[:first_name]
                  Customer.ci_first_name_find_all(parameters[:first_name])
                elsif parameters[:last_name]
                  Customer.ci_last_name_find_all(parameters[:last_name])
                else
                  Customer.where(parameters)
                end
    render json: CustomerSerializer.new(customers)
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
end
