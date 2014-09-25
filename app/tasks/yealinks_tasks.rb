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
              xml.Telephone "#{phone.value.strip}"
            end 
          }
        end
      }
    end
    File.open("phones.xml", "w") { |file| file.write builder. to_xml(indent: 2, indent_text: " ") }
  end
end