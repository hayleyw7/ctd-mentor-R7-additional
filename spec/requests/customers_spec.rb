require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do
    it "works! (now write some real specs)" do
      get customers_index_path
      expect(response).to have_http_status(200)
    end
  end
end
