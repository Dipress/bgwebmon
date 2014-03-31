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
      "#{m.login}#{' '*(30-m.login.length)}*#{' '*15}#{m.password}#{' '*(30-m.password.length)}#{m.addressFrom.bytes.to_a.join('.')}"
    end

    #Создаем файл в RAILS_ROOT и добавляем туда данные из массива
    File.open("chap-secrets", "w"){|file| file.write add_members.join("\n") }
    #Добавим в конец файла пустую строку(так надо)
    File.open("chap-secrets", "a"){|file| file.write "\n" }
    

    #Данные об удаленном сервере, смотри в application.yml
    host = ENV["REMOTE_HOST"]
    username = ENV["REMOTE_USER"]
    password = ENV["REMOTE_PASSWORD"]

    Net::SCP.start(host, username, password: password) do |scp|
      scp.upload("chap-secrets", "/etc/ppp/")
    end

    #Удадяем файл из RAILS_ROOT
    File.delete("chap-secrets")

    #Файл с данными логин, IP-адрес, шейпер
    shaiper_members = members.map do |m|
      if m.deviceOptions.to_i.eql?(2)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}64"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}64"
        end
      elsif m.deviceOptions.to_i.eql?(4)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}128"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}128"
        end
      elsif m.deviceOptions.to_i.eql?(5)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}256"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}256"
        end
      elsif m.deviceOptions.to_i.eql?(6)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}512"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}512"
        end
      elsif m.deviceOptions.to_i.eql?(8)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}1024"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}1024"
        end
      elsif m.deviceOptions.to_i.eql?(11)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}1536"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}1536"
        end
      elsif m.deviceOptions.to_i.eql?(9)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}2048"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}2048"
        end
      elsif m.deviceOptions.to_i.eql?(12)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}2560"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}2560"
        end
      elsif m.deviceOptions.to_i.eql?(10)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}3072"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}3072"
        end
      elsif m.deviceOptions.to_i.eql?(13)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}4096"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}4096"
        end
      elsif m.deviceOptions.to_i.eql?(14)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}5120"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}5120"
        end
      elsif m.deviceOptions.to_i.eql?(15)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}6144"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}6144"
        end
      elsif m.deviceOptions.to_i.eql?(16)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}7162"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}7162"
        end
      elsif m.deviceOptions.to_i.eql?(17)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}8192"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}8192"
        end
      elsif m.deviceOptions.to_i.eql?(18)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}9216"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}9216"
        end
      elsif m.deviceOptions.to_i.eql?(20)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}10240"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}10240"
        end
      elsif m.deviceOptions.to_i.eql?(26)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}12288"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}12288"
        end
      elsif m.deviceOptions.to_i.eql?(28)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}15360"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}15360"
        end
      elsif m.deviceOptions.to_i.eql?(25)
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}20480"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}20480"
        end
      else
        if m.deviceState.to_i.eql?(1)
          "#{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}2048"
        else
          "##{m.login}#{' '*(30-m.login.length)} #{m.addressFrom.bytes.to_a.join('.')}#{' '*(m.addressFrom.bytes.to_a.join('.').length)}2048"
        end
      end   
    end
    File.open("shaper", "w"){|file| file.write shaiper_members.join("\n")}
    #Добавим в конец файла пустую строку(так надо)
    File.open("shaper", "a"){|file| file.write "\n" }

    Net::SCP.start(host, username, password: password) do |scp|
      scp.upload("shaper", "/etc/ppp/")
    end

    File.delete("shaper")

    sleep(10)

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
