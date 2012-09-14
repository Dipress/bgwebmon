# coding: utf-8
require 'rrd' 

class MonitoringController < ApplicationController
before_filter :checklogedin, :only => [:index, :show, :errorlist, :payments]
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

  def dpupdate
    render :json => insertspeed(params[:ip],
      					   params[:rx],
      					   params[:tx])
  end

  def payments
    render :json => get_pays(params[:id])
  end

private 
#payments
  def get_pays(cid)
    contract = Contract.find(cid)
    pays = contract.payments.order('dt ASC').limit(10)
    array = []
    pays.each{|p| array << {:date => russiantime(p.dt),
                            :comment => p.comment,
                            :summa => "#{sprintf('%.02f',p.summa)}"}}
    return array
  end

# graph
  def create_graph(lid,hour)
    d = Dialupalias.find(lid) 
    time = Time.now.to_i - (60*60*hour)
    ago = Time.now - hour.hours
    c = d.contract
    name = "График абонента #{c.title} - #{c.comment}, c #{ago.strftime('%d.%m.%Y %H:%M:%S')} по #{Time.now.strftime('%d.%m.%Y %H:%M:%S')}"
    image_name = "#{d.login_alias.downcase}_#{Time.now.strftime("%Y%m%d%H%M%S%12N")}"
    cmd = "rrdtool graph /var/www/bgwebmon/public/graphs/#{image_name}.png -s #{time} -w 860 -h 200 -a PNG -t '#{name}'  --base=1024  -v='скорость килобит в секунду' --slope-mode  --lower-limit=0 DEF:a='/var/www/bgwebmon/graphs/#{d.login_alias.downcase}.rrd':download:AVERAGE AREA:a#00CC00:'Входящий трафик' DEF:b='/var/www/bgwebmon/graphs/#{d.login_alias.downcase}.rrd':upload:AVERAGE LINE1:b#0000FF:'Исходящий трафик'"
    system(cmd)
    return "/graphs/#{image_name}.png"
  end

# список ошибок
  def errors(id)
    errors = Dialuplogin.find(id).dialuperrors.order('dt ASC').limit(10)
    array = []
    errors.each{|e| array << {:date => russiantime(e.dt),
                              :error_code => e.error_code}}
    return array

  end

# Обработка параметров
  # Добавляем скорость RailsRRDtools
  def insertspeed(ip,rx,tx)
    if dialupip = Dialupip.find_aton(ip)
      if(!rx.nil? && !tx.nil?)
        dialuplogin = dialupip.dialuplogin
        if rx.to_i < dialuplogin.rx
          upload = 0
        else
          upload = ((((rx.to_i - dialuplogin.rx)*8)/60)/1024)
        end
        if tx.to_i < dialuplogin.tx
          download = 0
        else
          download = ((((tx.to_i - dialuplogin.tx)*8)/60)/1024)
        end
        if dialuplogin.update_attributes(:rx => rx, :tx => tx, :online => true)
          login = dialuplogin.dialupalias.login_alias
          RRD.update(Rails.root.join('graphs/' + login.to_s + '.rrd'), [upload,download])
          return "обновленно"
        else
          "ошибка"
        end
      else
        "rx, tx обязательны"
      end
    else
        "нет такого ip"
    end
  end

  def make_logins_array(like)
    larray = []
    time = Time.now
    Dialupalias.all.each {|s|
      contract = s.contract
      if contract.title =~ like
        larray << {:online => s.dialuplogin.online, 
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

  def russiantime(date)
    montharr = ["января", "февраля", "марта", "апреля",
                "мая", "июня", "июля", "августа", 
                "сентября", "октября", "ноября", "декабря"]
    return "#{date.day} #{montharr[date.month-1]} #{date.year}"
  end


end
