# coding: utf-8
class ApiController < ApplicationController
before_filter :ip_check
  def monitoring
=begin    larray = []
    time = Time.now
    Dialupalias.all.each {|s|
      contract = s.contract
      if contract.title =~ /^13-/
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
    }
    render json: {members: larray.sort_by {|l| l[:title]}, total: larray.length}
=end
    redner json: "Заблокировано связи с нарушением законодательства о защите персональных данных"
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

