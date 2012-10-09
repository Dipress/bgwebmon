require 'spec_helper'

describe RequestController do

  describe "GET 'Index'" do
    it "returns http success" do
      get 'Index'
      response.should be_success
    end
  end

  describe "GET 'Show'" do
    it "returns http success" do
      get 'Show'
      response.should be_success
    end
  end

  describe "GET 'Status'" do
    it "returns http success" do
      get 'Status'
      response.should be_success
    end
  end

end
