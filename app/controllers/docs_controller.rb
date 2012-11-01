# coding: utf-8
class DocsController < ApplicationController
  before_filter :checklogedin
  before_filter :ip_check
  before_filter :sadmin
  def index
    @contracts = Contract.where(["pgid=? or pgid=? and status=?",1,2,0]).order("title ASC")
    @title= "Статусы наличия подписаных договоров"
  end
end
