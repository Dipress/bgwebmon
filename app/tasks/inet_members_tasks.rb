# coding: utf-8
require 'net/scp'
require 'net/ssh'

class InetMembersTasks

  def self.datageneration
    #Находим данные по клиентам с нашего NAS по полю deviceId
    #где deviceId=12 это NAS Симферополя
    members = InetService.where(deviceId: 12)

    #Создаем наш массив содержащий нужные нам данные
    add_members = members.map do |m|
      if m.deviceState.to_i.eql?(1)
        "#{m.login}#{' '*(30-m.login.length)}*#{' '*15}#{m.password}#{' '*(30-m.password.length)}#{m.addressFrom.to_s.bytes.to_a.join('.')}"
      else
        "##{m.login}#{' '*(30-m.login.length)}*#{' '*15}#{m.password}#{' '*(30-m.password.length)}#{m.addressFrom.to_s.bytes.to_a.join('.')}"
      end
    end

    #Создаем файл в RAILS_ROOT и добавляем туда данные из массива
    File.open("chap-secrets", "w"){|file| file.write add_members.join("\n") }
    #Добавим в конец файла пустую строку(так надо)
    File.open("chap-secrets", "a"){|file| file.write "\n" }


    #Данные об удаленном сервере, смотри в application.yml
    #host = ENV["REMOTE_HOST"]
    #username = ENV["REMOTE_USER"]
    #password = ENV["REMOTE_PASSWORD"]

    #Net::SCP.start(host, username, password: password) do |scp|
      #scp.upload("chap-secrets", "/etc/ppp/")
    #end

    host2 = ENV["REMOTE_HOST_2"]
    username2 = ENV["REMOTE_USER_2"]
    password2 = ENV["REMOTE_PASSWORD_2"]

    Net::SCP.start(host2, username2, password: password2) do |scp|
      scp.upload("chap-secrets", "/etc/ppp/")
    end

    #Удадяем файл из RAILS_ROOT
    File.delete("chap-secrets")

    #Файл с данными логин, IP-адрес, шейпер
    shaiper_members = members.map do |m|
      if m.deviceOptions.to_i.eql?(2)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}64"
      elsif m.deviceOptions.to_i.eql?(4)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom..to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}128"
      elsif m.deviceOptions.to_i.eql?(5)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}256"
      elsif m.deviceOptions.to_i.eql?(6)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}512"
      elsif m.deviceOptions.to_i.eql?(8)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}1024"
      elsif m.deviceOptions.to_i.eql?(11)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}1536"
      elsif m.deviceOptions.to_i.eql?(9)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}2048"
      elsif m.deviceOptions.to_i.eql?(12)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}2560"
      elsif m.deviceOptions.to_i.eql?(10)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}3072"
      elsif m.deviceOptions.to_i.eql?(13)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}4096"
      elsif m.deviceOptions.to_i.eql?(14)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}5120"
      elsif m.deviceOptions.to_i.eql?(15)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}6144"
      elsif m.deviceOptions.to_i.eql?(16)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}7162"
      elsif m.deviceOptions.to_i.eql?(17)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}8192"
      elsif m.deviceOptions.to_i.eql?(18)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}9216"
      elsif m.deviceOptions.to_i.eql?(20)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}10240"
      elsif m.deviceOptions.to_i.eql?(26)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}12288"
      elsif m.deviceOptions.to_i.eql?(28)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}15360"
      elsif m.deviceOptions.to_i.eql?(25)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}20480"
      else
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}2048"
      end
    end
    File.open("shaper", "w"){|file| file.write shaiper_members.join("\n")}
    #Добавим в конец файла пустую строку(так надо)
    File.open("shaper", "a"){|file| file.write "\n" }

    #Net::SCP.start(host, username, password: password) do |scp|
      #scp.upload("shaper", "/etc/ppp/")
    #end

    Net::SCP.start(host2, username2, password: password2) do |scp|
      scp.upload("shaper", "/etc/ppp/")
    end

    File.delete("shaper")

    sleep(10)
    
    ########################## Bahchisarai ############################################################

    members = InetService.where(deviceId: 11)

    #Создаем наш массив содержащий нужные нам данные
    add_members = members.map do |m|
      if m.deviceState.to_i.eql?(1)
        "#{m.login}#{' '*(30-m.login.length)}*#{' '*15}#{m.password}#{' '*(30-m.password.length)}#{m.addressFrom.to_s.bytes.to_a.join('.')}"
      else
        "##{m.login}#{' '*(30-m.login.length)}*#{' '*15}#{m.password}#{' '*(30-m.password.length)}#{m.addressFrom.to_s.bytes.to_a.join('.')}"
      end
    end

    #Создаем файл в RAILS_ROOT и добавляем туда данные из массива
    File.open("chap-secrets", "w"){|file| file.write add_members.join("\n") }
    #Добавим в конец файла пустую строку(так надо)
    File.open("chap-secrets", "a"){|file| file.write "\n" }

    host = ENV["REMOTE_BHZ_HOST"]
    username = ENV["REMOTE_BHZ_USER"]
    password = ENV["REMOTE_BHZ_PASSWORD"]

    Net::SSH.start(host, username, password: password, port: 2202 ) do |ssh|
      ssh.scp.upload!("chap-secrets", ".")
    end

    File.delete("chap-secrets")

    #Файл с данными логин, IP-адрес, шейпер
    shaiper_members = members.map do |m|
      if m.deviceOptions.to_i.eql?(2)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}64"
      elsif m.deviceOptions.to_i.eql?(4)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom..to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}128"
      elsif m.deviceOptions.to_i.eql?(5)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}256"
      elsif m.deviceOptions.to_i.eql?(6)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}512"
      elsif m.deviceOptions.to_i.eql?(8)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}1024"
      elsif m.deviceOptions.to_i.eql?(11)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}1536"
      elsif m.deviceOptions.to_i.eql?(9)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}2048"
      elsif m.deviceOptions.to_i.eql?(12)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}2560"
      elsif m.deviceOptions.to_i.eql?(10)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}3072"
      elsif m.deviceOptions.to_i.eql?(13)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}4096"
      elsif m.deviceOptions.to_i.eql?(14)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}5120"
      elsif m.deviceOptions.to_i.eql?(15)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}6144"
      elsif m.deviceOptions.to_i.eql?(16)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}7162"
      elsif m.deviceOptions.to_i.eql?(17)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}8192"
      elsif m.deviceOptions.to_i.eql?(18)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}9216"
      elsif m.deviceOptions.to_i.eql?(20)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}10240"
      elsif m.deviceOptions.to_i.eql?(26)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}12288"
      elsif m.deviceOptions.to_i.eql?(28)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}15360"
      elsif m.deviceOptions.to_i.eql?(25)
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}20480"
      else
        "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.to_s.bytes.to_a.join('.')}#{' '*(m.addressFrom.to_s.bytes.to_a.join('.').length)}2048"
      end
    end
    File.open("shaper", "w"){|file| file.write shaiper_members.join("\n")}
    #Добавим в конец файла пустую строку(так надо)
    File.open("shaper", "a"){|file| file.write "\n" }

    Net::SSH.start(host, username, password: password, port: 2202 ) do |ssh|
      ssh.scp.upload!("shaper", ".")
    end

    File.delete("shaper")

    sleep(10)


    ######################### Kiril server ####################################################################################################

    members = InetService.where(deviceId: 10)

    add_members = members.map do |m|
      "#{m.login}\t\t#{m.password}\t\t#{m.addressFrom.bytes.to_a.join('.')}"
    end

    File.open("members.txt", "w"){|file| file.write add_members.join("\n") }

    host = ENV["KIRIL_REMOTE_HOST"]
    username = ENV["KIRIL_REMOTE_USER"]
    password = ENV["KIRIL_REMOTE_PASSWORD"]

    Net::SCP.start(host, username, password: password) do |scp|
      scp.upload("members.txt", ".")
    end

    File.delete("members.txt")
  end
end
