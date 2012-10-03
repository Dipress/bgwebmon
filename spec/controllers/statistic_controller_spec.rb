require 'spec_helper'

describe StatisticController do
  render_views
  it "GET 'index'" do
    get :index
    response.should redirect_to(login_path)
  end

  describe "Lodeg" do

    before(:each) do 
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "GET 'index'" do
      it "returns http success" do
        get :index
        response.should be_success
      end
    end
    describe "GET 'show'" do
      it "returns http success" do
        get :show
        response.should be_success
      end
    end
  end

end