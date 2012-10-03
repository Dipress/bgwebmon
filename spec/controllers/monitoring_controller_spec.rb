# coding: utf-8
require 'spec_helper'

describe MonitoringController do
  render_views

    before(:each) do
      @contract = Factory(:contract)
      @dialuplogin = Factory(:dialuplogin, :contract => @contract)
      @dialuperror = Factory(:dialuperror, :contract => @contract, :dialuplogin => @dialuplogin)
      @dialupalias = Factory(:dialupalias, :dialuplogin => @dialuplogin)
      @dialupip = Factory(:dialupip, :dialuplogin => @dialuplogin)
      @dialuperror = Factory(:dialuperror, :contract => @contract, :dialuplogin => @dialuplogins)
      @payment_type = Factory(:payment_type)
      @payment = Factory(:payment, :contract => @contract, :payment_type => @payment_type)
      @balance = Factory(:balance, :contract => @contract)
      @user = Factory(:user)
    end

  it "GET 'index'" do
    get :index
    response.should redirect_to(login_path)
  end

  describe "Lodeg" do

    before(:each) do 
      test_sign_in(@user)
   end

    describe "GET 'mon'" do
     it "returns http success" do
        get :mon
        response.should be_success
      end
    end

    describe "GET 'index'" do
     it "returns http success" do
        get :index
        response.should be_success
      end
    end

    describe "GET 'show'" do
     it "returns http success" do
        get :show, :id => @dialuplogin.id
        response.should be_success
     end
    end

    describe "GET 'errorlist'" do
      it "запрос должен быть успешным" do
        get :errorlist, :id => @dialupalias.id
        response.should be_success
      end
      it "должен возвращать json" do
        get :errorlist, :id => @dialupalias.id
        response.header['Content-Type'].should include 'application/json'
      end
    end

    describe "GET 'tariffs'" do
      it "запрос должен быть успешным" do
        get :tariffs, :id => @contract.id
        response.should be_success
      end
      it "должен возвращать json" do
        get :tariffs, :id => @contract.id
        response.header['Content-Type'].should include 'application/json'
      end
    end


    describe "GET 'payments'" do
      it "запрос должен быть успешным" do
        get :payments, :id => @contract.id
        response.should be_success
      end
      it "должен возвращать json" do
        get :payments, :id => @contract.id
        response.header['Content-Type'].should include 'application/json'
      end
    end

    describe "GET 'show'" do
      it "запрос должен быть успешным" do
        get :show, :id => @dialupalias.id, :hour => 6
        response.should be_success
      end
      it "должен возвращать json" do
        get :show, :id => @dialupalias.id, :hour => 6
        response.header['Content-Type'].should include 'application/json'
      end
    end

  end
end
