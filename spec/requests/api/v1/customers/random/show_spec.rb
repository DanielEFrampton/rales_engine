# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @ids = [@customer_1.id,
            @customer_2.id,
            @customer_3.id]
    @first_names = [@customer_1.first_name,
                    @customer_2.first_name,
                    @customer_3.first_name]
    @last_names = [@customer_1.last_name,
                   @customer_2.last_name,
                   @customer_3.last_name]
  end

  describe 'when I send a get request to the customers random path' do
    before(:each) do
      get '/api/v1/customers/random'
      @hash = JSON.parse(response.body)
    end

    it 'I get a JSON:API response containing attributes of a random customer' do
      expect(@hash.class).to eq(Hash)
      expect(@hash.keys).to eq(['data'])
      expect(@hash['data'].length).to eq(3)
      expect(@hash['data'].class).to eq(Hash)

      expect(@ids).to include(@hash['data']['id'].to_i)
      expect(@hash['data']['type']).to eq('customer')

      expect(@hash['data']['attributes'].class).to eq(Hash)
      expect(@hash['data']['attributes'].length).to eq(3)
      expect(@first_names).to include(@hash['data']['attributes']['first_name'])
      expect(@last_names).to include(@hash['data']['attributes']['last_name'])
      expect(@ids).to include(@hash['data']['attributes']['id'])
    end
  end
end
