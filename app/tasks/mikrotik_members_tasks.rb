# coding: utf-8
require "mtik"

class MikrotikMembersTasks

	def self.datagenerate

		#Находим всех абонентов которые крутяться в биллинге в папке "NAS-Симферополь".
		members = InetService.where(deviceId: 12)

		#Соединяемся с MikroTik.
		mikrotik = MTik::Connection.new(host: "172.28.200.42", pass: "temp_mikrotik")

		#Создаем пустой массив, в котором будет хранить данные о текущих абонентах
		#которые сейчас присутствуют в базе Mikrotik. Нам это будет нужно для того,
		#чтобы удалить их, а замем записать новые, актуальные, данные о абонетах.
		users = {}

		#Заполняем массив.
		mikrotik.get_reply_each("/ppp/secret/print") do |r,s|
      if s.key?("!re") && s.key?("name")
        users[s["name"]] = {  
          :name => s["name"],
          :id   => s[".id"]
        }
      end
    end

    #Чистим текущею базу Mikrotik.
    users.map do |user|
      mikrotik.get_reply("/ppp/secret/remove", "=.id=#{users[user[1][:name]][:id]}")
    end

    #Начинаем процесс добавление новых, актуальных данных о пользователях
    members.map do |m|
    	if m.deviceState.to_i.eql?(1)
    		if m.deviceOptions.to_i.eql?(2)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_64kb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(4)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_128kb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(5)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_256kb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(6)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_512kb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(8)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_1Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(11)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_1.5Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(9)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_2Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(12)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_2.5Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(10)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_3Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(13)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_4Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(14)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_5Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(15)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_6Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(16)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_7Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(17)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_8Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(18)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_9Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(20)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_10Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(26)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_12Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(28)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_15Mb"})
    			sleep(0.3)
    		elsif m.deviceOptions.to_i.eql?(25)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_20Mb"})
    			sleep(0.3)
    		else
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"profile" => "vpn_2Mb"})
    			sleep(0.3)
    		end
    	end
    end

    #Закрываем сессию с Mikrotik
    mikrotik.close
  end
end