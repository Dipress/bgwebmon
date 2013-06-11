require 'spec_helper'

describe ApiController do

  describe "GET 'monitoring'" do
    it "returns http success" do
      get 'monitoring'
      response.should be_success
    end
  end

end
