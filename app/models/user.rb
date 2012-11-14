class User < ActiveRecord::Base
  self.table_name = "user"
  self.primary_key = "id"

  has_many :requestfl
  has_many :tasks
  has_many :tcomments

  #protected
  def self.authenticate(username="", password="")
  		user = User.where("login='" + username + "'").first
  		if user && user.password_match?(password ,username)
  			return user
  		else
  			return false
  		end
  end

  def self.superadmin(id)
    User.find(id).contract_cid.eql?(0) ? true : false
  end

  #protected
  def self.hash(password="")
  		Digest::MD5.hexdigest(password).upcase
  end

  #protected
  def password_match?(password="", username="")
  	    user = User.where("login='" + username + "'").first
  		if user != nil
  			if user.pswd == User.hash(password)
  				return true
  			else
  				return false
  			end
  		else
  			return false
  		end
  end
end