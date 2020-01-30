# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe 'when I send a get request to the merchants show path' do
    before(:each) do
      get "/api/v1/merchants/#{@merchant_1.id}"
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of all merchants' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)
      expect(@hash['data'].class).to eq(Hash)

      expect(@hash['data']['id']).to eq(@merchant_1.id.to_s)
      expect(@hash['data']['type']).to eq('merchant')
      expect(@hash['data']['attributes'].class).to eq(Hash)
      expect(@hash['data']['attributes'].length).to eq(2)
      expect(@hash['data']['attributes']['name']).to eq(@merchant_1.name.to_s)
      expect(@hash['data']['attributes']['id']).to eq(@merchant_1.id)

      expect(@hash.to_s).not_to include(@merchant_2.name.to_s)
    end
  end
end
