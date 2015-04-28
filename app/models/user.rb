class User < ActiveRecord::Base
  self.table_name = "user"
  self.primary_key = "id"

  has_many :requestfl
  has_many :notes
  has_many :tasks
  has_many :tcomments
  has_many :agent_payments
  has_many :agent_payments, as: :manager
  has_many :agent_payments, as: :confirmation

  has_many :bgsusergroups, class_name: "Bgsusergroup", foreign_key: "uid"
  has_many :bgsgroups, through: :bgsusergroups

  #protected
  def self.authenticate(username="", password="")
  		user = User.where("login='" + username + "'").first
  		if user && user.password_match?(password ,username)
  			return user
  		else
  			return false
  		end
  end

  def self.superadmin id 
    User.find(id).contract_cid.eql?(0) ? true : false
  end

  def self.acceptor_payments id 
    group = User.find(id).bgsusergroups.all.map do |g|
      g.gid
    end
    group.include?(6) ? true : false
  end

  def self.member id 
    group = User.find(id).bgsusergroups.all.map do |g|
      g.gid
    end
    group.include?(7) ? true : false
    
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