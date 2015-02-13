# coding: utf-8
require "mtik"

class MikrotikMembersTasks

	def self.datagenerate

		#Находим всех абонентов которые крутяться в биллинге в папке "NAS-Симферополь".
		members = InetService.where(deviceId: 12)

		#Соединяемся с MikroTik.

		host = ENV["MIKROTIK_HOST"]
		password = ENV["MIKROTIK_PASSWORD"]

		mikrotik = MTik::Connection.new(host: host, pass: password)

		#Создаем пустой массив, в котором будем хранить данные о текущих абонентах,
		#которые сейчас присутствуют в базе Mikrotik. Нам это будет нужно для того,
		#чтобы удалить их, а затем записать новые, актуальные, данные о абонетах.
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

    #Чистим текущую базу Mikrotik.
    users.map do |user|
      mikrotik.get_reply("/ppp/secret/remove", "=.id=#{users[user[1][:name]][:id]}")
    end

    #Начинаем процесс добавление новых, актуальных данных о абонентах
    members.map do |m|
    	if m.deviceState.to_i.eql?(1)
    		if m.deviceOptions.to_i.eql?(2)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_64kb"})
    		elsif m.deviceOptions.to_i.eql?(4)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_128kb"})
    		elsif m.deviceOptions.to_i.eql?(5)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_256kb"})
    		elsif m.deviceOptions.to_i.eql?(6)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_512kb"})
    		elsif m.deviceOptions.to_i.eql?(8)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_1Mb"})
    		elsif m.deviceOptions.to_i.eql?(11)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_1.5Mb"})
    		elsif m.deviceOptions.to_i.eql?(9)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_2Mb"})
    		elsif m.deviceOptions.to_i.eql?(12)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_2.5Mb"})
    		elsif m.deviceOptions.to_i.eql?(10)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_3Mb"})
    		elsif m.deviceOptions.to_i.eql?(13)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_4Mb"})
    		elsif m.deviceOptions.to_i.eql?(14)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_5Mb"})
    		elsif m.deviceOptions.to_i.eql?(15)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_6Mb"})
    		elsif m.deviceOptions.to_i.eql?(16)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_7Mb"})
    		elsif m.deviceOptions.to_i.eql?(17)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_8Mb"})
    		elsif m.deviceOptions.to_i.eql?(18)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_9Mb"})
    		elsif m.deviceOptions.to_i.eql?(20)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_10Mb"})
    		elsif m.deviceOptions.to_i.eql?(26)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_12Mb"})
    		elsif m.deviceOptions.to_i.eql?(28)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_15Mb"})
    		elsif m.deviceOptions.to_i.eql?(25)
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_20Mb"})
    		else
    			mikrotik.get_reply("/ppp/secret/add", {"local-address" => "10.0.0.0"}, {"name" =>"#{m.login}"}, {"password" => "#{m.password}"}, {"remote-address" => "#{m.addressFrom.to_s.bytes.to_a.join('.')}"}, {"disabled" => "yes"}, {"comment" => "#{Time.now.asctime}"}, {"profile" => "vpn_2Mb"})
    		end
    	end
    end

    #Закрываем сессию с Mikrotik
    mikrotik.close
  end
end