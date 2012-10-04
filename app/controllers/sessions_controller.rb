# coding: utf-8
class SessionsController < ApplicationController
before_filter :ip_check
  def new
  end

  def create
  	user = User.authenticate(params[:session][:login],
  							             params[:session][:password])
  	if user
  		login(user)
  		redirect_to root_path
  	else
  		redirect_to login_path, :notice => "Неправильный логин/пароль"
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
