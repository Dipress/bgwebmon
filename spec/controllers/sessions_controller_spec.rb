# coding: utf-8
require 'spec_helper'

describe SessionsController do
  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end
  describe "POST 'create'" do
  	let(:user) { Factory(:user) }
    describe "правильный user" do
    	it "должен залогинить пользователя" do
	    	post :create, :session => {:login => user.login, :password => "test2011"}
	    	controller.current_user.should eq(user)
        controller.should be_loged_in
	    end
	    it "должен перенаправить на главную странницу" do
	    	post :create, :session => {:login => user.login, :password => "test2011"}
	    	response.should redirect_to(root_path)
	    end
    end
    describe "неправильный user" do
      it "неправильная почта" do
        post :create, :session => {:login => user.login, :password => "password"}
        response.should redirect_to(login_path)
      end
      it "несовподает пароль" do
        post :create, :session => {:login => "login", :password => user.pswd}
        response.should redirect_to(login_path)
      end
    end
    describe "DELETE 'destroy'" do
      it "должен удалить сессию пользователя" do
        test_sign_in(user)
        delete :destroy
        controller.current_user.should equal(nil)
        controller.should_not be_loged_in
        response.should redirect_to(login_path)
      end
    end
  end

end
