# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
#  force_ssl

  def login(user)
    session[:user_id] = user.id
  end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def loged_in?
    session[:user_id].nil? ? false : true
  end

  def checklogedin
    loged_in? ? true : redirect_to(login_path)
  end

  def search_title
    u = current_user
    if u.contract_cid != 0
      title = /^#{Contract.find(u.contract_cid).title.gsub(/000/, "")}/
    else
      title = //
    end
  end

end
