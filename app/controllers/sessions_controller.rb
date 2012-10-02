# coding: utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.authenticate(params[:session][:login],
  							 params[:session][:password])
  	if user
  		login(user)
  		redirect_to root_path
  	else
      flash.now[:notice] = "Неправильный логин/пароль"
  		redirect_to login_path
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
