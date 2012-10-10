# coding: utf-8
require 'spec_helper'

describe Requeststatus do
  let(:user){Factory(:user)}
  let(:requeststatus){Factory(:requeststatus)}
  let(:tariffplan){Factory(:tariffplan)}
  let(:requestfl){Factory(:requestfl, :user => user, :requeststatus => requeststatus, :tariffplan => tariffplan)}
  describe "Отношения" do
  	it "respond .requestfl" do
  		requeststatus.should respond_to(:requestfls)
  	end
  	it ".user" do
  		requeststatus.requestfls.first == requestfl
  	end
  end

  describe "Валидация" do
  	describe "Поле title" do
  		it "должно быть заполнено" do
  			blank_title = requeststatus
  			blank_title.title = nil
  			blank_title.should_not be_valid
  		end
  		it "не может быть меньше 5 символов" do
  			small_title = requeststatus
  			small_title.title = "a" * 4
  			small_title.should_not be_valid
  		end
  		it "не может быть больше 31 символов" do
  			large_title = requeststatus
  			large_title.title = "a" * 31
  			large_title.should_not be_valid
  		end
  	end
  end
end
