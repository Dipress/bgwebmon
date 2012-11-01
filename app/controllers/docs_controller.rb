class DocsController < ApplicationController
  before_filter :checklogedin
  before_filter :ip_check
  before_filter :sadmin
  def index
    @contracts = Contract.all.order("title ASC")
    @title= "Статусы наличия подписаных договоров"
  end
end
