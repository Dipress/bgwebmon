# coding: utf-8

class MonitoringController < ApplicationController
before_filter :checklogedin, :only => [:index, :show, :errorlist, :payments, :tariffs]
  def index
  	@dialupalias = make_logins_array(search_title())
    @time = Time.now
  	@title = "Все графики"
  end

  def show
    render :json => create_graph(params[:id],params[:hour].to_i)
  end

  def errorlist
    render :json => errors(params[:id])
  end

  def tariffs
    render :json => Contract.tariffs_array(params[:id])
  end

  def payments
    render :json => get_pays(params[:id])
  end

private 
#payments
  def get_pays(cid)
    contract = Contract.find(cid)
    pays = contract.payments.order('dt ASC')
    array = []
    pays.each{|p| array << {:date => russiantime(p.dt),
                            :comment => p.comment,
                            :summa => "#{sprintf('%.02f',p.summa)}"}}
    return array
  end

# graph
  def create_graph(lid,hour)
    d = Dialupip.find(lid) 
    ip = Dialupip.ntoa(d.ip).gsub(/\./,"")
    time = Time.now.to_i - (60*60*hour)
    ago = Time.now - hour.hours
    c = d.contract
    name = "График абонента #{c.title} - #{c.comment}, c #{ago.strftime('%d.%m.%Y %H:%M:%S')} по #{Time.now.strftime('%d.%m.%Y %H:%M:%S')}"
    image_name = "#{ip}_#{Time.now.strftime("%Y%m%d%H%M%S%12N")}"
    cmd = "rrdtool graph /var/www/webmon/current/public/graphs/#{image_name}.png -b 1024 -s #{time} -w 860 -h 200 -a PNG -t '#{name}' -v='скорость бит в секунду' --slope-mode  --lower-limit=0 DEF:a='/var/www/graphs/#{ip}.rrd':download:AVERAGE AREA:a#00CC00:'Входящий трафик' DEF:b='/var/www/graphs/#{ip}.rrd':upload:AVERAGE LINE1:b#0000FF:'Исходящий трафик'"
    system(cmd)
    return "/graphs/#{image_name}.png"
  end

# список ошибок
  def errors(id)
    errors = Dialuplogin.find(id).dialuperrors.order('log_rec_id DESC').limit(15)
    array = []
    errors.each{|e| array << {:date => russiantime(e.dt),
                              :error_code => e.error_code}}
    return array
  end

  def make_logins_array(like)
    larray = []
    time = Time.now
    Dialupalias.all.each {|s|
      contract = s.contract
      if contract.title =~ like
        if s.dialuplogin.dialupip != nil
          ip = Dialupip.ntoa(s.dialuplogin.dialupip.ip)
        else
          ip = "1"
        end
        larray << {:online => check_online(ip), 
                   :login_alias => s.login_alias, 
                   :comment => contract.comment, 
                   :title => contract.title,
                   :closesumma => contract.closesumma,
                   :balance => Balance.balance("#{contract.id}",
                                               "#{time.strftime("%m")}",
                                               "#{time.strftime("%Y")}"),
                   :login_id => s.id,
                   :id => contract.id}
      end
    }
    return larray.sort_by {|l| l[:title]}
  end

  def check_online(ip)
      cmd="rrdtool fetch /var/www/graphs/#{ip.gsub(/\./,"")}.rrd AVERAGE -r 300 -s -120"
      rxtx=`#{cmd}`
      if rxtx != ""
        rxtx=rxtx.gsub(/[0-9].+\:.+/).first.gsub(/[0-9]+\:\ /, "")
        if rxtx =~ /-nan/
          return false
        else
          return true
        end
      else
        return false
      end
  end

  def russiantime(date)
    montharr = ["января", "февраля", "марта", "апреля",
                "мая", "июня", "июля", "августа", 
                "сентября", "октября", "ноября", "декабря"]
    return "#{date.day} #{montharr[date.month-1]} #{date.year}"
  end


end