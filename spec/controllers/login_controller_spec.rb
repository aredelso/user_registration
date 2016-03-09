require 'rails_helper'

RSpec.describe LoginController, type: :controller do

  describe "GET #do" do
    it "returns http success" do
      get :do
      expect(response).to have_http_status(:success)
    end
  end

end
