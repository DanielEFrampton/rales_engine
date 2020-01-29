class Api::V1::Merchants::FindController < ApplicationController
  def show
    search_params = parameters
    render json: MerchantSerializer.new(Merchant.find_by(search_params))
  end

  private

    def parameters
      if params[:name]
        params[:name] = params[:name].titlecase
      end
      params.permit(:name, :id, :created_at, :updated_at)
    end
end
