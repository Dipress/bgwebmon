# coding: utf-8
require 'net/scp'
require 'net/ssh'

class UsersFullyDataTasks

  #deviceId = this is NAS id
  #ipResourceId - show into module Inet -> IP resourses
  #current_template  - It looks like the module Inet
  #right_template - as it should be in dokuwiki

  def self.data_by_node
    generate_data(12, 22, '10.22.186', '172.28.186')  #Красногорка
    generate_data(12, 23, '10.22.187', '172.28.187')  #Виноградное
    generate_data(12, 24, '10.22.190', '172.28.190')  #Семисотка
    generate_data(12, 25, '10.22.192', '172.28.192')  #Новониколаевка
    generate_data(12, 26, '10.22.193', '172.28.193')  #Ленинское
    generate_data(12, 27, '10.20.230', '172.28.195')  #Вишневое PPoE
    generate_data(12, 28, '10.22.199', '172.28.199')  #Сененовка
    generate_data(12, 29, '10.10.230', '172.28.230')  #Симферополь PPtP
    generate_data(12, 30, '10.10.231', '172.28.204')  #Симферополь PPtP
    generate_data(12, 34, '10.10.233', '172.28.197')  #Вишневое PPtP
    generate_data(12, 75, '10.20.231', '172.28.196')  #Вишневое PPoE secondary
    generate_data(12, 76, '10.22.183', '172.28.183')  #Сененовка secondary
    generate_data(12, 78, '10.22.172', '172.28.172')  #Фронтовое
    generate_data(12, 79, '10.22.174', '172.28.174')  #Соленое
    generate_data(12, 80, '10.22.176', '172.28.176')  #Фонтан
    generate_data(12, 81, '10.22.178', '172.28.178')  #Щелкино-Мысовое
    generate_data(12, 82, '10.22.180', '172.28.180')  #Каменское
  end

  def self.generate_data device, resourse, current_template, right_template
    data = ip_resourse(device, resourse)
    total_data = data.map do |d|
      "|[[http://#{d.addressFrom.to_s.bytes.to_a.join('.').gsub(current_template, right_template)}|#{d.addressFrom.to_s.bytes.to_a.join('.').gsub(current_template, right_template)}]]" +
       "|#{ContractParameterType1.where(cid: d.contractId, pid: 71).map {|x| x.val}.first} " +
       "|#{ContractParameterType7Value.where(id: "#{ContractParameterType7.where(cid: d.contractId, pid: 68).map {|x| x.val}.first}").map {|x| x.title }.first} " +
       "| " +
       "|#{Contract.find(d.contractId).title}" +
       "|#{Contract.find(d.contractId).comment}" +
       "|#{d.login}:#{d.password}" +
       "|#{d.comment}|"
    end

    total_data = total_data.sort_by! {|ip| ip.split('.').map{ |octet| octet.to_i} }

    #Create file and push data to file
    File.open("#{right_template}.0_robot.txt", "w"){|file| file.write "==== в биллинге #{current_template}.0/24 Clients ==== \n"}
    File.open("#{right_template}.0_robot.txt", "a"){|file| file.write "^  IP адрес        ^  MAC      ^  Оборудование  ^  Линк     ^  Договор  ^  Владелец     ^  Доступ     ^  Примечания    ^\n"}
    File.open("#{right_template}.0_robot.txt", "a"){|file| file.write "^ ^ ^ ^ ^ ^ ^ ^ ^\n" }
    File.open("#{right_template}.0_robot.txt", "a"){|file| file.write total_data.join("\n") }
    File.open("#{right_template}.0_robot.txt", "a"){|file| file.write "\n" }

    #send file to dokuwiki server
    host = ENV["REMOTE_WIKI_HOST"]
    username = ENV["REMOTE_WIKI_USER"]
    password = ENV["REMOTE_WIKI_PASSWORD"]

    Net::SCP.start(host, username, password: password) do |scp|
      scp.upload("#{right_template}.0_robot.txt", "/var/lib/dokuwiki/data/pages/ip-fake/")
    end

    #delete file on rails app root
    File.delete("#{right_template}.0_robot.txt")

  end

  #search data in module Inet by deviceId and ipResourceId
  def self.ip_resourse device, resourse
    InetService.where(deviceId: device, ipResourceId: resourse)
  end
end
