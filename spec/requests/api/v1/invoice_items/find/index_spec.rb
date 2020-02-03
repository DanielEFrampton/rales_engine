# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)
    @item_5 = create(:item, merchant: @merchant)
    @item_6 = create(:item, merchant: @merchant)
    @customer = create(:customer)
    @customer_2 = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
    @invoice_2 = create(:invoice, customer: @customer_2, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item,
                             item: @item_1,
                             invoice: @invoice,
                             updated_at: '2032-01-01') # unique ID, updated_at
    @invoice_item_2 = create(:invoice_item,
                             item: @item_2,
                             invoice: @invoice,
                             quantity: 23) # unique quantity
    @invoice_item_3 = create(:invoice_item,
                             item: @item_3,
                             invoice: @invoice,
                             unit_price: 60000) # unique unit_price
    @invoice_item_4 = create(:invoice_item,
                             item: @item_4,
                             invoice: @invoice) # unique item_id
    @invoice_item_5 = create(:invoice_item,
                             item: @item_5,
                             invoice: @invoice,
                             created_at: '1234-12-23') # unique created_at
    @invoice_item_6 = create(:invoice_item,
                             item: @item_6,
                             invoice: @invoice_2) # unique invoice_id
    @invoice_item_1a = create(:invoice_item,
                             item: @item_1,
                             invoice: @invoice,
                             updated_at: '2032-01-01') # unique updated_at
    @invoice_item_2a = create(:invoice_item,
                             item: @item_2,
                             invoice: @invoice,
                             quantity: 23) # unique quantity
    @invoice_item_3a = create(:invoice_item,
                             item: @item_3,
                             invoice: @invoice,
                             unit_price: 60000) # unique unit_price
    @invoice_item_4a = create(:invoice_item,
                             item: @item_4,
                             invoice: @invoice) # unique item_id
    @invoice_item_5a = create(:invoice_item,
                             item: @item_5,
                             invoice: @invoice,
                             created_at: '1234-12-23') # unique created_at
    @invoice_item_6a = create(:invoice_item,
                             item: @item_6,
                             invoice: @invoice_2) # unique invoice_id
  end

  describe 'when I send a get request to the invoice_items find_all path' do
    describe 'by its id attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?id=#{@invoice_item_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(1)

        expected = [@invoice_item_1]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its quantity attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?quantity=#{@invoice_item_2.quantity}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_2, @invoice_item_2a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its unit_price attribute' do
      before(:each) do
        formatted_price = sprintf('%.2f', @invoice_item_3.unit_price / 100.0)
        get "/api/v1/invoice_items/find_all?unit_price=#{formatted_price}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_3, @invoice_item_3a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?updated_at=#{@invoice_item_1.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_1, @invoice_item_1a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?created_at=#{@invoice_item_5.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_5, @invoice_item_5a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its invoice_id attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_item_6.invoice_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_6, @invoice_item_6a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end

    describe 'by its item_id attribute' do
      before(:each) do
        get "/api/v1/invoice_items/find_all?item_id=#{@invoice_item_4.item_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response with attributes of that invoice_item' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_item_4, @invoice_item_4a]
        @json['data'].each_with_index do |item, index|
          expect(item['id']).to eq(expected[index].id.to_s)
          expect(item['type']).to eq('invoice_item')

          attributes = item['attributes']

          formatted_price = sprintf('%.2f', expected[index].unit_price / 100.0)
          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['item_id']).to eq(expected[index].item_id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['quantity']).to eq(expected[index].quantity)
          expect(attributes['unit_price']).to eq(formatted_price)
        end
      end
    end
  end
end
