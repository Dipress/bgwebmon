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
      "#{m.login}\t\t#{m.password}\t\t#{m.addressFrom.bytes.to_a.join('.')} 2048"
    end

    #Создаем файл в RAILS_ROOT и добавляем туда данные из массива
    File.open("members.txt", "w"){|file| file.write add_members.join("\n") }
    

    #Данные об удаленном сервере, смотри в application.yml
    host = ENV["REMOTE_HOST"]
    username = ENV["REMOTE_USER"]
    password = ENV["REMOTE_PASSWORD"]

    Net::SCP.start(host, username, password: password) do |scp|
      #Загружаем файл на удалленый сервер
      #вначале указываем путь куда зарузить
      #затем пишет откуда взять файл
      scp.upload("members.txt", "/root/")
    end

    #Удадяем файл из RAILS_ROOT
    File.delete("members.txt")

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
