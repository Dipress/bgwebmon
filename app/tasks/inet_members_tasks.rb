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
