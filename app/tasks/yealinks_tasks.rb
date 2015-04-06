# coding: utf-8
require 'net/scp'
require 'net/ssh'
require 'nokogiri'

class YealinksTasks

  def self.mobiledata
    contracts = Contract.all
    builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.IPPhoneDirectory { 
        xml.Title "Remote Phonelist" 
        contracts.each do |contract| 
          xml.DirectoryEntry { 
            xml.Name "#{contract.title} #{contract.comment}"
            contract.phones.each do |phone|
              if phone.value.start_with?("065")
                xml.Telephone "+380" + "#{phone.value.strip}".match(/[0-9]{9}$/).to_s
              elsif phone.value.start_with?("0065")
                xml.Telephone "+380" + "#{phone.value.strip}".match(/[0-9]{9}$/).to_s
              elsif phone.value.start_with?("8065")
                xml.Telephone "+380" + "#{phone.value.strip}".match(/[0-9]{9}$/).to_s
              elsif phone.value.start_with?("7")
                xml.Telephone "+" + "#{phone.value.strip}"
              else
                xml.Telephone "#{phone.value.strip}"
              end
            end 
          }
        end
      }
    end
    File.open("phones.xml", "w") { |file| file.write builder. to_xml(indent: 2, indent_text: " ") }

    host = ENV["ATC_HOST"]
    username = ENV["ATC_USER"]
    password = ENV["ATC_PASSWORD"]

    Net::SCP.start(host, username, password: password) do |scp|
      scp.upload("phones.xml", "/var/www/phone")
    end

    File.delete("phones.xml")

  end
end
