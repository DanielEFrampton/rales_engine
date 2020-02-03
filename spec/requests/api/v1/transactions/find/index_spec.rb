# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer, merchant: @merchant)
    @invoice_2 = create(:invoice, customer: @customer, merchant: @merchant)
    @transaction_1 = create(:transaction,
                            invoice: @invoice)  # unique id, first 'success'
    @transaction_2 = create(:transaction,
                            invoice: @invoice,
                            result: 'failed',
                            credit_card_number: '1234123412341234') # unique #
    @transaction_3 = create(:transaction,
                            invoice: @invoice,
                            result: 'failed',
                            created_at: '2020-02-02') # unique created_at
    @transaction_4 = create(:transaction,
                            invoice: @invoice,
                            updated_at: '1985-10-22') # unique updated_at
    @transaction_5 = create(:transaction,
                            invoice: @invoice,
                            result: 'borked')         # unique result
    @transaction_6 = create(:transaction,
                            invoice: @invoice,
                            result: 'failed')
    @transaction_7 = create(:transaction,
                            invoice: @invoice_2,
                            result: 'failed')     # unique invoice_id
    @transaction_2a = create(:transaction,
                            invoice: @invoice,
                            result: 'failed',
                            credit_card_number: '1234123412341234') # unique #
    @transaction_3a = create(:transaction,
                            invoice: @invoice,
                            result: 'failed',
                            created_at: '2020-02-02') # unique created_at
    @transaction_4a = create(:transaction,
                            invoice: @invoice,
                            updated_at: '1985-10-22') # unique updated_at
    @transaction_5a = create(:transaction,
                            invoice: @invoice,
                            result: 'borked')         # unique result
    @transaction_6a = create(:transaction,
                            invoice: @invoice,
                            result: 'failed')
    @transaction_7a = create(:transaction,
                            invoice: @invoice_2,
                            result: 'failed')     # unique invoice_id
  end

  describe 'when I send a get request to the transactions find_all path' do
    describe 'by its id attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?id=#{@transaction_1.id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(1)

        expected = [@transaction_1]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end

    describe 'by its (case-insensitive) result attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?result=#{@transaction_5.result.upcase}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_5, @transaction_5a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end

    describe 'by its created_at attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?created_at=#{@transaction_3.created_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_3, @transaction_3a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end      end
    end

    describe 'by its updated_at attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?updated_at=#{@transaction_4.updated_at}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_4, @transaction_4a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end

    describe 'by its invoice_id attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?invoice_id=#{@transaction_7.invoice_id}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_7, @transaction_7a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end

    describe 'by its credit_card_number attribute' do
      before(:each) do
        get "/api/v1/transactions/find_all?credit_card_number=#{@transaction_2.credit_card_number}"
        @json = JSON.parse(response.body)
      end

      it 'I get a JSON:API response containing attributes of that invoice' do
        expect(@json.class).to eq(Hash)
        expect(@json.keys).to eq(['data'])
        expect(@json['data'].class).to eq(Array)
        expect(@json['data'].length).to eq(2)

        expected = [@transaction_2, @transaction_2a]
        @json['data'].each_with_index do |transaction, index|
          expect(transaction['id']).to eq(expected[index].id.to_s)
          expect(transaction['type']).to eq('transaction')

          attributes = transaction['attributes']

          expect(attributes['id']).to eq(expected[index].id)
          expect(attributes['invoice_id']).to eq(expected[index].invoice_id)
          expect(attributes['result']).to eq(expected[index].result)
          expect(attributes['credit_card_number']).to eq(expected[index].credit_card_number)
        end
      end
    end
  end
end
