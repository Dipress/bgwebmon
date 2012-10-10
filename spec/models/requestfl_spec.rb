# coding: utf-8
require 'spec_helper'

describe Requestfl do
  let(:user){Factory(:user)}
  let(:requeststatus){Factory(:requeststatus)}
  let(:tariffplan){Factory(:tariffplan)}
  let(:requestfl){Factory(:requestfl, :user => user, :requeststatus => requeststatus, :tariffplan => tariffplan)}
  describe "Отношения" do
  	it "respond .user" do
  		requestfl.should respond_to(:user)
  	end
  	it ".user" do
  		requestfl.user.should eql(user)
  	end
  	it "respond .requeststatus" do
  		requestfl.should respond_to(:requeststatus)
  	end
  	it ".requeststatus" do
  		requestfl.requeststatus.should eql(requeststatus)
  	end
  	it "respond .tariffplan" do
  		requestfl.should respond_to(:tariffplan)
  	end
  	it ".tariffplan" do
  		requestfl.tariffplan.should eql(tariffplan)
  	end
  end

  describe "Валидация" do
  	describe "Поле fio" do
  		it "должно быть заполнено" do
  			blank_fio = requestfl
  			blank_fio.fio = nil
  			blank_fio.should_not be_valid
  		end
  		it "не может быть больше 70 символов" do
  			large_fio = requestfl
  			large_fio.fio = "a" * 71
  			large_fio.should_not be_valid
  		end
  	end
  	describe "Поле adress_post" do
  		it "должно быть заполнено" do
  			blank_adress_post = requestfl
  			blank_adress_post.adress_post = nil
  			blank_adress_post.should_not be_valid
  		end
  		it "не может быть больше 150 символов" do
  			large_adress_post = requestfl
  			large_adress_post.adress_post = "a" * 151
  			large_adress_post.should_not be_valid
  		end
  	end
  	describe "Поле adress_connection" do
  		it "должно быть заполнено" do
  			blank_adress_connection = requestfl
  			blank_adress_connection.adress_connection = nil
  			blank_adress_connection.should_not be_valid
  		end
  		it "не может быть больше 150 символов" do
  			large_adress_connection = requestfl
  			large_adress_connection.adress_connection = "a" * 151
  			large_adress_connection.should_not be_valid
  		end
  	end
  	describe "Поле latlng_connection" do
  		it "должно быть заполнено" do
  			blank_latlng_connection = requestfl
  			blank_latlng_connection.latlng_connection = nil
  			blank_latlng_connection.should_not be_valid
  		end
  		it "не может быть больше 100 символов" do
  			large_latlng_connection = requestfl
  			large_latlng_connection.latlng_connection = "a" * 101
  			large_latlng_connection.should_not be_valid
  		end
  	end
  	describe "Поле telephone" do
  		it "должно быть заполнено" do
  			blank_telephone = requestfl
  			blank_telephone.telephone = nil
  			blank_telephone.should_not be_valid
  		end
  		it "иметь правильный формат" do
  			wrong_format_telephone = requestfl
  			wrong_telephones = ["3784563423", "++380507333423", "380501234567+"]
  			wrong_telephones.each{|t|
	  			wrong_format_telephone.telephone = t
	  			wrong_format_telephone.should_not be_valid
	  		}
  		end
  	end
  	describe "Поле in" do
  		it "должно быть заполнено" do
  			blank_in = requestfl
  			blank_in.in = nil
  			blank_in.should_not be_valid
  		end
  		it "не может быть больше 30 символов" do
  			large_in = requestfl
  			large_in.in = "a" * 31
  			large_in.should_not be_valid
  		end
  	end
  	describe "Поле pasport" do
  		it "должно быть заполнено" do
  			blank_pasport = requestfl
  			blank_pasport.pasport = nil
  			blank_pasport.should_not be_valid
  		end
  		it "не может быть больше 20 символов" do
  			large_pasport = requestfl
  			large_pasport.pasport = "a" * 21
  			large_pasport.should_not be_valid
  		end
  	end
  	describe "Поле pasport_authority" do
  		it "должно быть заполнено" do
  			blank_pasport_authority = requestfl
  			blank_pasport_authority.pasport_authority = nil
  			blank_pasport_authority.should_not be_valid
  		end
  		it "не может быть больше 60 символов" do
  			large_pasport_authority = requestfl
  			large_pasport_authority.pasport_authority = "a" * 61
  			large_pasport_authority.should_not be_valid
  		end
  	end
  	describe "Поле pd" do
  		it "должно быть заполнено" do
  			blank_pd = requestfl
  			blank_pd.pd = nil
  			blank_pd.should_not be_valid
  		end
  		it "иметь правильный формат" do
  			wrong_format_pd = requestfl
  			wrong_pds = ["41.02.2012", "21.21.2012", "2012.21.02", "2012.02.21", "20120221"]
  			wrong_pds.each{|t|
	  			wrong_format_pd.pd = t
	  			wrong_format_pd.should_not be_valid
	  		}
  		end
  	end
  	describe "Поле payment_form" do
  		it "должно быть заполнено" do
  			blank_payment_form = requestfl
  			blank_payment_form.payment_form = nil
  			blank_payment_form.should_not be_valid
  		end
  		it "иметь правильный тип данных" do
  			wrong_type_payment_form = requestfl
  			wrong_payment_forms = [nil, "sd", "", %w[some om], 23.02, requestfl]
  			wrong_payment_forms.each{|t|
	  			wrong_type_payment_form.payment_form = t
	  			wrong_type_payment_form.should_not be_valid
	  		}
  		end
  	end
  	describe "Поле ip" do
  		it "должно быть заполнено" do
  			blank_ip = requestfl
  			blank_ip.ip = nil
  			blank_ip.should_not be_valid
  		end
  		it "не может быть меньше 9 символов" do
  			small_ip = requestfl
  			small_ip.ip = "a" * 8
  			small_ip.should_not be_valid
  		end
  		it "не может быть больше 15 символов" do
  			large_ip = requestfl
  			large_ip.ip = "a" * 16
  			large_ip.should_not be_valid
  		end
  	end
  	describe "Поле login" do
  		it "должно быть заполнено" do
  			blank_login = requestfl
  			blank_login.login = nil
  			blank_login.should_not be_valid
  		end
  		it "не может быть меньше 3 символов" do
  			small_login = requestfl
  			small_login.login = "a" * 2
  			small_login.should_not be_valid
  		end
  		it "не может быть больше 15 символов" do
  			large_login = requestfl
  			large_login.login = "a" * 16
  			large_login.should_not be_valid
  		end
  	end
  	describe "Поле password" do
  		it "должно быть заполнено" do
  			blank_password = requestfl
  			blank_password.password = nil
  			blank_password.should_not be_valid
  		end
  		it "не может быть меньше 3 символов" do
  			small_password = requestfl
  			small_password.password = "a" * 2
  			small_password.should_not be_valid
  		end
  		it "не может быть больше 15 символов" do
  			large_password = requestfl
  			large_password.password = "a" * 16
  			large_password.should_not be_valid
  		end
  	end
  	describe "Поле technology" do
  		it "должно быть заполнено" do
  			blank_technology = requestfl
  			blank_technology.technology = nil
  			blank_technology.should_not be_valid
  		end
  		it "иметь правильный тип данных" do
  			wrong_type_technology = requestfl
  			wrong_technologys = [nil, "sd", "", %w[some om], 23.02, requestfl]
  			wrong_technologys.each{|t|
	  			wrong_type_technology.technology = t
	  			wrong_type_technology.should_not be_valid
	  		}
  		end
  	end
  	describe "Поле node" do
  		it "должно быть заполнено" do
  			blank_node = requestfl
  			blank_node.node = nil
  			blank_node.should_not be_valid
  		end
  		it "иметь правильный тип данных" do
  			wrong_type_node = requestfl
  			wrong_nodes = [nil, "sd", "", %w[some om], 23.02, requestfl]
  			wrong_nodes.each{|t|
	  			wrong_type_node.node = t
	  			wrong_type_node.should_not be_valid
	  		}
  		end
  	end
  	describe "Поле tariffplan_id" do
  		it "должно быть заполнено" do
  			blank_tariffplan_id = requestfl
  			blank_tariffplan_id.tariffplan_id = nil
  			blank_tariffplan_id.should_not be_valid
  		end
  		it "иметь правильный тип данных" do
  			wrong_type_tariffplan_id = requestfl
  			wrong_tariffplan_ids = [nil, "sd", "", %w[some om], 23.02, requestfl]
  			wrong_tariffplan_ids.each{|t|
	  			wrong_type_tariffplan_id.tariffplan_id = t
	  			wrong_type_tariffplan_id.should_not be_valid
	  		}
  		end
  	end
  end
end
