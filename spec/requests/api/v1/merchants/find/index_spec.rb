require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    @merchant_1 = create(:merchant, name: 'Common Name')
    @merchant_2 = create(:merchant, name: 'Common Name')
    @merchant_3 = create(:merchant, created_at: Time.zone.parse("2020-01-10"))
    @merchant_4 = create(:merchant, created_at: Time.zone.parse("2020-01-10"))
    @merchant_5 = create(:merchant, updated_at: Time.zone.parse("2020-01-15"))
    @merchant_6 = create(:merchant, updated_at: Time.zone.parse("2020-01-15"))
    @merchant_7 = create(:merchant, updated_at: Time.zone.parse("2020-01-15"))
    @merchant_8 = create(:merchant)
  end

  describe 'when I send a get request to the merchants find index path' do
    describe 'by their name attribute (case-insensitive)' do
      before(:each) do
        get "/api/v1/merchants/find_all?name=#{@merchant_2.name.downcase}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON response with attributes of all matching merchants' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(["data"])
        expect(@hash["data"].class).to eq(Array)
        expect(@hash["data"].length).to eq(2)

        expect(@hash["data"][0]["id"]).to eq("#{@merchant_1.id}")
        expect(@hash["data"][0]["type"]).to eq("merchant")
        expect(@hash["data"][0]["attributes"].class).to eq(Hash)
        expect(@hash["data"][0]["attributes"].length).to eq(2)
        expect(@hash["data"][0]["attributes"]["name"]).to eq("#{@merchant_1.name}")
        expect(@hash["data"][0]["attributes"]["id"]).to eq(@merchant_1.id)

        expect(@hash["data"][1]["id"]).to eq("#{@merchant_2.id}")
        expect(@hash["data"][1]["type"]).to eq("merchant")
        expect(@hash["data"][1]["attributes"].class).to eq(Hash)
        expect(@hash["data"][1]["attributes"].length).to eq(2)
        expect(@hash["data"][1]["attributes"]["name"]).to eq("#{@merchant_2.name}")
        expect(@hash["data"][1]["attributes"]["id"]).to eq(@merchant_2.id)

        expect(@hash.to_s).not_to include("#{@merchant_3.name}")
        expect(@hash.to_s).not_to include("#{@merchant_4.name}")
        expect(@hash.to_s).not_to include("#{@merchant_5.name}")
        expect(@hash.to_s).not_to include("#{@merchant_6.name}")
        expect(@hash.to_s).not_to include("#{@merchant_7.name}")
        expect(@hash.to_s).not_to include("#{@merchant_8.name}")
      end
    end

    describe 'by their id attribute' do
      before(:each) do
        get "/api/v1/merchants/find_all?id=#{@merchant_8.id}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON response with attributes of all matching merchants' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(["data"])
        expect(@hash["data"].class).to eq(Array)
        expect(@hash["data"].length).to eq(1)

        expect(@hash["data"][0]["id"]).to eq("#{@merchant_8.id}")
        expect(@hash["data"][0]["type"]).to eq("merchant")
        expect(@hash["data"][0]["attributes"].class).to eq(Hash)
        expect(@hash["data"][0]["attributes"].length).to eq(2)
        expect(@hash["data"][0]["attributes"]["name"]).to eq("#{@merchant_8.name}")
        expect(@hash["data"][0]["attributes"]["id"]).to eq(@merchant_8.id)

        expect(@hash.to_s).not_to include("#{@merchant_1.name}")
        expect(@hash.to_s).not_to include("#{@merchant_2.name}")
        expect(@hash.to_s).not_to include("#{@merchant_3.name}")
        expect(@hash.to_s).not_to include("#{@merchant_4.name}")
        expect(@hash.to_s).not_to include("#{@merchant_5.name}")
        expect(@hash.to_s).not_to include("#{@merchant_6.name}")
        expect(@hash.to_s).not_to include("#{@merchant_7.name}")
      end
    end

    describe 'by their created_at attribute' do
      before(:each) do
        get "/api/v1/merchants/find_all?created_at=#{@merchant_3.created_at.to_s}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON response with attributes of all matching merchants' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(["data"])
        expect(@hash["data"].class).to eq(Array)
        expect(@hash["data"].length).to eq(2)

        expect(@hash["data"][0]["id"]).to eq("#{@merchant_3.id}")
        expect(@hash["data"][0]["type"]).to eq("merchant")
        expect(@hash["data"][0]["attributes"].class).to eq(Hash)
        expect(@hash["data"][0]["attributes"].length).to eq(2)
        expect(@hash["data"][0]["attributes"]["name"]).to eq("#{@merchant_3.name}")
        expect(@hash["data"][0]["attributes"]["id"]).to eq(@merchant_3.id)

        expect(@hash["data"][1]["id"]).to eq("#{@merchant_4.id}")
        expect(@hash["data"][1]["type"]).to eq("merchant")
        expect(@hash["data"][1]["attributes"].class).to eq(Hash)
        expect(@hash["data"][1]["attributes"].length).to eq(2)
        expect(@hash["data"][1]["attributes"]["name"]).to eq("#{@merchant_4.name}")
        expect(@hash["data"][1]["attributes"]["id"]).to eq(@merchant_4.id)

        expect(@hash.to_s).not_to include("#{@merchant_1.name}")
        expect(@hash.to_s).not_to include("#{@merchant_2.name}")
        expect(@hash.to_s).not_to include("#{@merchant_5.name}")
        expect(@hash.to_s).not_to include("#{@merchant_6.name}")
        expect(@hash.to_s).not_to include("#{@merchant_7.name}")
        expect(@hash.to_s).not_to include("#{@merchant_8.name}")
      end
    end

    describe 'by their updated_at attribute' do
      before(:each) do
        get "/api/v1/merchants/find_all?updated_at=#{@merchant_5.updated_at.to_s}"
        @hash = JSON.parse(response.body)
      end

      it 'I get a JSON response with attributes of all matching merchants' do
        expect(@hash.class).to eq(Hash)
        expect(@hash.keys).to eq(["data"])
        expect(@hash["data"].class).to eq(Array)
        expect(@hash["data"].length).to eq(3)

        expect(@hash["data"][0]["id"]).to eq("#{@merchant_5.id}")
        expect(@hash["data"][0]["type"]).to eq("merchant")
        expect(@hash["data"][0]["attributes"].class).to eq(Hash)
        expect(@hash["data"][0]["attributes"].length).to eq(2)
        expect(@hash["data"][0]["attributes"]["name"]).to eq("#{@merchant_5.name}")
        expect(@hash["data"][0]["attributes"]["id"]).to eq(@merchant_5.id)

        expect(@hash["data"][1]["id"]).to eq("#{@merchant_6.id}")
        expect(@hash["data"][1]["type"]).to eq("merchant")
        expect(@hash["data"][1]["attributes"].class).to eq(Hash)
        expect(@hash["data"][1]["attributes"].length).to eq(2)
        expect(@hash["data"][1]["attributes"]["name"]).to eq("#{@merchant_6.name}")
        expect(@hash["data"][1]["attributes"]["id"]).to eq(@merchant_6.id)

        expect(@hash["data"][2]["id"]).to eq("#{@merchant_7.id}")
        expect(@hash["data"][2]["type"]).to eq("merchant")
        expect(@hash["data"][2]["attributes"].class).to eq(Hash)
        expect(@hash["data"][2]["attributes"].length).to eq(2)
        expect(@hash["data"][2]["attributes"]["name"]).to eq("#{@merchant_7.name}")
        expect(@hash["data"][2]["attributes"]["id"]).to eq(@merchant_7.id)

        expect(@hash.to_s).not_to include("#{@merchant_1.name}")
        expect(@hash.to_s).not_to include("#{@merchant_2.name}")
        expect(@hash.to_s).not_to include("#{@merchant_3.name}")
        expect(@hash.to_s).not_to include("#{@merchant_4.name}")
        expect(@hash.to_s).not_to include("#{@merchant_8.name}")
      end
    end
  end
end
