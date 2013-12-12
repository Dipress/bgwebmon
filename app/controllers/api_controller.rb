# coding: utf-8
class ApiController < ApplicationController
before_filter :ip_check
  def asterisk
    p params[:password]
    p Base64.encode64(ENV['ASTERISK_KEY']).gsub(/\n/, '')
    if params[:password] == Base64.encode64(ENV['ASTERISK_KEY']).gsub(/\n/, '')
      phone = Phone.where(["value LIKE ?", "%#{params[:phone]}"]).limit(1)
      if phone.length == 0 
        render json: '', status: :not_found
      else
        render json: phone.first.contract, serializer: AsteriskContractSerializer
      end
    else
      render json: '', status: :unauthorized
    end
  end

  def test_java_curl
    p "GOT CURL REQUEST FROM BILLING!!!!!!!!!!!!!!!!!"
    render json: 'ok'
  end

  def monitoring
    if request.remote_ip == '194.54.152.39'
      larray = []
      time = Time.now
      Dialupalias.all.each do |s|
        contract = s.contract
        if contract && contract.title =~ /^13-/
          if s.dialuplogin.dialupip != nil
            ip = Dialupip.ntoa(s.dialuplogin.dialupip.ip)
          else
            ip = "1"
          end
            last_payment = contract.payments.order('dt ASC').last
              larray << {account_id: contract.title,
                         account_name: contract.comment,
                         status: check_online(ip),
                         last_payment_date: last_payment.nil? ? nil : last_payment.dt,
                         last_payment_value: last_payment.nil? ? nil : last_payment.summa,
                         balance: Balance.balance("#{contract.id}",
                                                  "#{time.strftime("%m")}",
                                                  "#{time.strftime("%Y")}"),
                         balance_limit: contract.closesumma}
        end
      end
      render json: {members: larray.sort_by {|l| l[:title]}, total: larray.length}
    else
      render json: "Заблокировано"
    end
  end
protected


  def check_online(ip)
      cmd="rrdtool fetch /var/www/graphs/#{ip.gsub(/\./,"")}.rrd AVERAGE -r 300 -s -120"
      rxtx=`#{cmd}`
      if rxtx && rxtx != ""
        rxtx=rxtx.gsub(/[0-9].+\:.+/).first.gsub(/[0-9]+\:\ /, "")
        if rxtx =~ /-nan/
          return 0
        else
          return 1
        end
      else
        return 0
      end
  end
end

