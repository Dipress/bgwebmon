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

#    describe "GET 'dpupdate'" do
#      it "запрос должен быть успешным" do
#        get :dpupdate, :ip => Dialupip.ntoa(@dialupip.ip)
#        response.should be_success
#      end
#      it "должен возвращать json" do
#        get :dpupdate, :ip => Dialupip.ntoa(@dialupip.ip)
#        response.header['Content-Type'].should include 'application/json'
#      end
#      it "запрос без ip должен возвращать значение \"нет такого ip\"" do
#        get :dpupdate, :ip => "127.255.255.255"
#        response.body.should == "нет такого ip"
#      end
#      it "запрос c ip должен возвращать значение \"rx, tx обязательны\"" do
#        get :dpupdate, :ip => Dialupip.ntoa(@dialupip.ip)
#        response.body.should == "rx, tx обязательны"
#      end
#      it "запрос должен возвращать \"обновленно\", если обновленно" do
#        get :dpupdate, :ip => Dialupip.ntoa(@dialupip.ip), :rx => 6000000, :tx => 6000000
#        response.body.should == "обновленно"
#      end  
#      it "запрос должен возвращать \"ошибка\", если не обновленно" do
#        get :dpupdate, :ip => Dialupip.ntoa(@dialupip.ip), :rx => "ss", :tx => 6000000
#        response.body.should == "ошибка"
#      end     
#    end

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
