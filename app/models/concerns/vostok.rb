require "net/http"
require "open-uri"
require "cgi"

module Vostok
  @default_options = {}

  class << self; attr_accessor :default_options; end

  class Sms
    attr_accessor :url

    def initialize(space, subno, text)
      @base_url = "https://sms.e-vostok.ru/smsout.php?#{base_params}"
      @url = URI.parse(@base_url + "&space=#{CGI.escape(space)}&subno=#{CGI.escape(subno)}&text=#{CGI.escape(text)}")
    end

    def send
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(@url.request_uri)
      http.request(request)
    end

    private

    def base_params
      Vostok.default_options.map{|key, value| "#{key}=#{CGI.escape(value)}&" }.join.gsub(/\&$/, '')
    end
  end
end