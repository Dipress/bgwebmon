class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def confirm_logged_in
  	unless session[:user_id]
  		flash[:notice] = "Аутинтифицируйтесь"
  		redirect_to(:controller => 'moderator', :action => 'login')
  		return false
  	else
  		return true
  	end
  end

  protected
  def mode
    if session[:cid] != ""
      flash[:notice] = "У вас нет прав"
      redirect_to(:controller => 'moderator', :action => 'login')
      return false
    else
      return true
    end
  end
end
