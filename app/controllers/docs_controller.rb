# coding: utf-8
class DocsController < ApplicationController
  before_filter :checklogedin
  before_filter :ip_check
  before_filter :sadmin
  def index
    @contracts = Contract.where( [ "(pgid=? or pgid=?) and status!=3", 3, 0, 2 ] ).order "title ASC"
    @most = Contract.where( [ "title LIKE ?", "%-000" ] ).order "title ASC"
    @title= "Статусы наличия подписаных договоров"
    @user = current_user
  end

  def show
  	@contracts = Contract.where( [ "status!=? AND title LIKE ? AND (pgid=? OR pgid=?)", 3, params[ :title ]+"%", 1, 2 ] ).order "title ASC"
    @most = Contract.where( [ "title LIKE ?", "%-000" ] ).order "title ASC"
    @title= "Статусы наличия подписаных договоров"
  	@user = current_user
  end
end
