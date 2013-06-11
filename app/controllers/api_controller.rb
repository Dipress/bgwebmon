class ApiController < ApplicationController
before_filter :ip_check
  def monitoring
    larray = []
    time = Time.now
    Dialupalias.all.each {|s|
      contract = s.contract
      if contract.title =~ /^13-/
        if s.dialuplogin.dialupip != nil
          ip = Dialupip.ntoa(s.dialuplogin.dialupip.ip)
        else
          ip = "1"
        end
            larray << {account_id: contract.title,
                       status: check_online(ip),
                       last_payment_date: contract.payments.order('dt ASC').last.dt ||= nil,
                       last_payment_value: contract.payments.order('dt ASC').last.summa ||= nil,
                       balance: Balance.balance("#{contract.id}",
                                                "#{time.strftime("%m")}",
                                                "#{time.strftime("%Y")}"),
                       balance_limit: contract.closesumma}
      end
    }
    render json: {members: larray.sort_by {|l| l[:title]}, total: larray.length}
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
