require 'nokogiri'
require 'open-uri'
require 'net/http'
class Ip2sms
  attr_accessor :phone, :text

  def initialize phone, text
    @body = xml phone, text
  end

  def uri
    URI.parse ENV['IP2SMS_URL']
  end

  def request
    req = Net::HTTP::Post.new uri.path
    req.body = @body
    req.basic_auth ENV['IP2SMS_LOGIN'], ENV['IP2SMS_PASSWORD']
    req
  end

  def send
    res = Net::HTTP.new(uri.host, uri.port).request request
    res.body
  end

  def xml phone, text
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.message do
        xml.service source: "INFOCOM", id: 'single'
        xml.to phone
        xml.body("content-type" => 'text/plain'){ xml.text text }
      end
    end.doc.root.to_xml
  end
end