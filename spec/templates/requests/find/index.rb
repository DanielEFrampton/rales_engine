require 'rails_helper'

RSpec.describe 'As a visitor', type: :request do
  before(:each) do
    # Create enough test data to have 1-2 records match each search parameter

    # Provide plural name of resource being requested; interpolated below.
    resources = ""
  end

  describe "when I send a get request to the #{resources} find index path" do

    # One block per possible search parameter
    describe 'by their name attribute' do
      before(:each) do
        # Get request
        get "/api/v1/#{resources}/find_all?name=#{@m_2.name.downcase}"
        # Assign
        @hash = JSON.parse(response.body)
      end

      it "I get a JSON response with attributes of all matching #{resources}" do
        # Test general attributes of response hash

        # Test attributes of individual resources in 'data'

        # Test that non-matching resources are not present
      end
    end
  end
end
