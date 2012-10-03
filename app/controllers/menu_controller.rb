# coding: utf-8
class MenuController < ApplicationController
before_filter :checklogedin, :only => [:index]
	def index
		@title = "мониторинг абонентов ООО Крыминфоком"
	end
end
