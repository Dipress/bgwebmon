# coding: utf-8
class MenuController < ApplicationController
before_filter :checklogedin
before_filter :ip_check
	def index
		@title = "мониторинг абонентов ООО Крыминфоком"
		@user = current_user()
	end
end
