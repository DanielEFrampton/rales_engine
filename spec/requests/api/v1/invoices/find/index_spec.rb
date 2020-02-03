# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @invoice_1 = create(:invoice,
                        customer: @customer_1,
                        merchant: @merchant_1)
    @invoice_2 = create(:invoice,
                        customer: @customer_1,
                        merchant: @merchant_2,
                        updated_at: '2020-01-01')
    @invoice_2a = create(:invoice,
                        customer: @customer_1,
                        merchant: @merchant_2,
                        updated_at: '2020-01-01')
    @invoice_3 = create(:invoice,
                        customer: @customer_1,
                        merchant: @merchant_3,
                        created_at: '2020-02-01')
    @invoice_3a = create(:invoice,
                        customer: @customer_1,
                        merchant: @merchant_3,
                        created_at: '2020-02-01')
    @invoice_4 = create(:invoice,
                        customer: @customer_2,
                        merchant: @merchant_1,
                        status: 'borked')
    @invoice_4a = create(:invoice,
                        customer: @customer_2,
                        merchant: @merchant_1,
                        status: 'borked')
  end

  describe 'when I send a get request to the invoices fin_all path' do
    describe 'by its id attribute case-insensitive' do
      before(:each) do
        get "/api/v1/invoices/find_all?id=#{@invoice_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing all matching invoices' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(1)

        expected = [@invoice_1]
        invoices = @json['data']
        invoices.each_with_index do |invoice, index|
          expect(invoice['id']).to eq(expected[index].id.to_s)
          expect(invoice['type']).to eq('invoice')

          attributes = invoice['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['customer_id']).to eq(expected[index].customer_id)
          expect(attributes['status']).to eq(expected[index].status)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end

    describe 'by its (case-insensitive) status attribute' do
      before(:each) do
        get "/api/v1/invoices/find_all?status=#{@invoice_4.status.upcase}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing all matching invoices' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_4, @invoice_4a]
        invoices = @json['data']
        invoices.each_with_index do |invoice, index|
          expect(invoice['id']).to eq(expected[index].id.to_s)
          expect(invoice['type']).to eq('invoice')

          attributes = invoice['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['customer_id']).to eq(expected[index].customer_id)
          expect(attributes['status']).to eq(expected[index].status)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/invoices/find_all?created_at=#{@invoice_3.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing all matching invoices' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_3, @invoice_3a]
        invoices = @json['data']
        invoices.each_with_index do |invoice, index|
          expect(invoice['id']).to eq(expected[index].id.to_s)
          expect(invoice['type']).to eq('invoice')

          attributes = invoice['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['customer_id']).to eq(expected[index].customer_id)
          expect(attributes['status']).to eq(expected[index].status)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/invoices/find_all?updated_at=#{@invoice_2.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing all matching invoices' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_2, @invoice_2a]
        invoices = @json['data']
        invoices.each_with_index do |invoice, index|
          expect(invoice['id']).to eq(expected[index].id.to_s)
          expect(invoice['type']).to eq('invoice')

          attributes = invoice['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['customer_id']).to eq(expected[index].customer_id)
          expect(attributes['status']).to eq(expected[index].status)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end

    describe 'by its merchant_id attribute' do
      before(:each) do
        get "/api/v1/invoices/find_all?merchant_id=#{@invoice_3.merchant_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing all matching invoices' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_3, @invoice_3a]
        invoices = @json['data']
        invoices.each_with_index do |invoice, index|
          expect(invoice['id']).to eq(expected[index].id.to_s)
          expect(invoice['type']).to eq('invoice')

          attributes = invoice['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['customer_id']).to eq(expected[index].customer_id)
          expect(attributes['status']).to eq(expected[index].status)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end

    describe 'by its customer_id attribute' do
      before(:each) do
        get "/api/v1/invoices/find_all?customer_id=#{@invoice_4.customer_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing all matching invoices' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].length).to eq(2)

        expected = [@invoice_4, @invoice_4a]
        invoices = @json['data']
        invoices.each_with_index do |invoice, index|
          expect(invoice['id']).to eq(expected[index].id.to_s)
          expect(invoice['type']).to eq('invoice')

          attributes = invoice['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['customer_id']).to eq(expected[index].customer_id)
          expect(attributes['status']).to eq(expected[index].status)
          expect(attributes['merchant_id']).to eq(expected[index].merchant_id)
        end
      end
    end
  end
end
