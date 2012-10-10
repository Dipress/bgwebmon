require 'spec_helper'

describe RequestController do
  let(:user){Factory(:user)}
  let(:requeststatus){Factory(:requeststatus)}
  let(:tariffplan){Factory(:tariffplan)}
  let(:requestfl){Factory(:requestfl, :user => user, :requeststatus => requeststatus, :tariffplan => tariffplan)}
  before(:each) do 
    test_sign_in(user)
  end
  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'requestfl'" do
    it "returns http success" do
      get :requestfl, :id => requestfl.id
      response.should be_success
    end
  end
end
