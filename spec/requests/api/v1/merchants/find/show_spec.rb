# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
  end

  describe 'when I send a get request to the merchants find path' do
    describe 'by its name attribute case-insensitive' do
      before(:each) do
        get "/api/v1/merchants/find?name=#{@merchant_2.name.downcase}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that merchant' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(3)
        expect(@hash['data'].class).to eq(Hash)

        expect(@hash['data']['id']).to eq(@merchant_2.id.to_s)
        expect(@hash['data']['type']).to eq('merchant')
        expect(@hash['data']['attributes'].class).to eq(Hash)
        expect(@hash['data']['attributes'].length).to eq(2)
        expect(@hash['data']['attributes']['name']).to eq(@merchant_2.name.to_s)
        expect(@hash['data']['attributes']['id']).to eq(@merchant_2.id)

        expect(@hash.to_s).not_to include(@merchant_1.name.to_s)
        expect(@hash.to_s).not_to include(@merchant_3.name.to_s)
        expect(@hash.to_s).not_to include(@merchant_4.name.to_s)
      end
    end

    describe 'by its id attribute' do
      before(:each) do
        get "/api/v1/merchants/find?id=#{@merchant_4.id}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that merchant' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(3)
        expect(@hash['data'].class).to eq(Hash)

        expect(@hash['data']['id']).to eq(@merchant_4.id.to_s)
        expect(@hash['data']['type']).to eq('merchant')
        expect(@hash['data']['attributes'].class).to eq(Hash)
        expect(@hash['data']['attributes'].length).to eq(2)
        expect(@hash['data']['attributes']['name']).to eq(@merchant_4.name.to_s)
        expect(@hash['data']['attributes']['id']).to eq(@merchant_4.id)

        expect(@hash.to_s).not_to include(@merchant_1.name.to_s)
        expect(@hash.to_s).not_to include(@merchant_2.name.to_s)
        expect(@hash.to_s).not_to include(@merchant_3.name.to_s)
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/merchants/find?created_at=#{@merchant_1.created_at}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that merchant' do
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

        expect(@hash.to_s).not_to include(@merchant_2.name)
        expect(@hash.to_s).not_to include(@merchant_3.name)
        expect(@hash.to_s).not_to include(@merchant_4.name)
      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/merchants/find?updated_at=#{@merchant_3.updated_at}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that merchant' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(['data'])
        expect(@hash['data'].length).to eq(3)
        expect(@hash['data'].class).to eq(Hash)

        expect(@hash['data']['id']).to eq(@merchant_3.id.to_s)
        expect(@hash['data']['type']).to eq('merchant')
        expect(@hash['data']['attributes'].class).to eq(Hash)
        expect(@hash['data']['attributes'].length).to eq(2)
        expect(@hash['data']['attributes']['name']).to eq(@merchant_3.name.to_s)
        expect(@hash['data']['attributes']['id']).to eq(@merchant_3.id)

        expect(@hash.to_s).not_to include(@merchant_1.name)
        expect(@hash.to_s).not_to include(@merchant_2.name)
        expect(@hash.to_s).not_to include(@merchant_4.name)
      end
    end
  end
end
