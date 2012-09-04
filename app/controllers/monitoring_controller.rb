# coding: utf-8
require 'rrd' 

class MonitoringController < ApplicationController
  http_basic_authenticate_with :name => "crmifc", :password => "crmifc2012",  :except => :dpupdate
def index
  	@dialupalias = Dialupalias.all
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
    pays = contract.payments.order('dt ASC').limit(5)
    array = []
    pays.each{|p| array << {:date => p.dt.strftime('%d.%m.%Y'),
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
    image_name = "#{d.login_alias}_#{Time.now.strftime("%Y%m%d%H%M%S%12N")}"
    cmd = "rrdtool graph /var/www/bgwebmon/public/graphs/#{image_name}.png -s #{time} -w 860 -h 200 -a PNG -t '#{name}'  --base=1024  -v='скорость килобит в секунду' --slope-mode  --lower-limit=0 DEF:a='/var/www/bgwebmon/graphs/#{d.login_alias}.rrd':download:AVERAGE AREA:a#00CC00:'Входящий трафик' DEF:b='/var/www/bgwebmon/graphs/#{d.login_alias}.rrd':upload:AVERAGE LINE1:b#0000FF:'Исходящий трафик'"
    system(cmd)
    return "/graphs/#{image_name}.png"
  end

# список ошибок
  def errors(id)
    Dialuplogin.find(id).dialuperrors.order('dt').limit(5)
  end

# Обработка параметров
  # Добавляем скорость RailsRRDtools
  def insertspeed(ip,rx,tx)
    if dialupip = Dialupip.find_aton(ip)
      if(!rx.nil? && !tx.nil?)
        dialuplogin = dialupip.dialuplogin
        upload = ((((rx.to_i - dialuplogin.rx)*8)/60)/1024)
        download = ((((tx.to_i - dialuplogin.tx)*8)/60)/1024)
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

end
