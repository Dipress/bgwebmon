# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def login(user)
    session[:user_id] = user.id
  end

  def ip_check
    allowed_ip? ? true : redirect_to("http://crimeainfo.com")
  end

  def allowed_ip?
    ips = ["194.54.154.141", 
           "194.54.154.132", 
           "194.54.154.133", 
           "194.54.152.66", 
           "194.54.152.67", 
           "194.54.152.8", 
           "127.0.0.1", 
           "172.28.200.3", 
           "172.28.200.17",
           "0.0.0.0",
           "195.20.28.252",
           "194.187.148.225",
           "195.20.29.130",
           "195.20.29.131",
           "194.187.148.7",
           "195.20.29.194"]
    return ips.include? request.remote_ip
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def loged_in?
    session[:user_id].nil? ? false : true
  end

  def checklogedin
    loged_in? ? true : redirect_to(login_path(:protocol => 'https'))
  end

  def sadmin
    User.superadmin(current_user) ? true : root_path  
  end

  def search_title
    u = current_user
    if u.contract_cid != 0
      title = /^#{Contract.find(u.contract_cid).title.gsub(/000/, "")}/
    else
      title = //
    end
  end

  def member(cid)
    current = current_user.contract_cid
    if current != 0
      cpt8 = ContractParameterType8.where(:cid => cid)
      if cpt8[0].nil?
        false
      else
        current.eql?(cpt8[0].val) ? true : false
      end
    else
      true
    end
  end

end
