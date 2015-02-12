require 'rails_helper'

RSpec.describe RankingsController, type: :controller do

  describe "GET #general" do
    it "returns http success" do
      get :general
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #weekly" do
    it "returns http success" do
      get :weekly
      expect(response).to have_http_status(:success)
    end
  end

end
