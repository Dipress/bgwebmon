class User < ActiveRecord::Base
  self.table_name = "user"
  self.primary_key = "id"

  #protected
  def self.authenticate(username="", password="")
  		user = Auth.where("login='" + username + "'").first
  		if user && user.password_match?(password ,username)
  			return user
  		else
  			return false
  		end
  end

  #protected
  def self.hash(password="")
  		Digest::MD5.hexdigest(password).upcase
  end

  #protected
  def password_match?(password="", username="")
  	    user = Auth.where("login='" + username + "'").first
  		if user != nil
  			if user.pswd == Auth.hash(password)
  				return true
  			else
  				return false
  			end
  		else
  			return false
  		end
  end
end