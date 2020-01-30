# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @ids = [@merchant_1.id, @merchant_2.id, @merchant_3.id]
    @names = [@merchant_1.name, @merchant_2.name, @merchant_3.name]
  end

  describe 'when I send a get request to the merchants random path' do
    before(:each) do
      get '/api/v1/merchants/random'
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of a random merchant' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)
      expect(@hash['data'].class).to eq(Hash)

      expect(@ids).to include(@hash['data']['id'].to_i)
      expect(@hash['data']['type']).to eq('merchant')

      expect(@hash['data']['attributes'].class).to eq(Hash)
      expect(@hash['data']['attributes'].length).to eq(2)
      expect(@names).to include(@hash['data']['attributes']['name'])
      expect(@ids).to include(@hash['data']['attributes']['id'])
    end
  end
end
