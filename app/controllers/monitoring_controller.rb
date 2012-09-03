# coding: utf-8
require 'rrd' 

class MonitoringController < ApplicationController
  http_basic_authenticate_with :name => "crmifc", :password => "crmifc2012",  :except => :dpupdate
def index
  	@dialupalias = Dialupalias.all
  	@title = "Все графики"
  end

  def show
    render :json => create_graph(params[:id])
  end

  def errorlist
    render :json => errors(params[:id])
  end

  def dpupdate
    render :json => insertspeed(params[:ip],
      					   params[:rx],
      					   params[:tx])
  end

private 
# graph
  def create_graph(lid)
    d = Dialupalias.find(lid)
    image_name = "#{d.login_alias}_#{Time.now.strftime("%Y%m%d%H%M%S%12N")}"
    RRD.graph('/var/www/bgwebmon/graphs/' + d.login_alias + '.rrd','/var/www/bgwebmon/public/graphs/' + image_name + '.png', {:ago => Time.now.to_i-(60*60*6),:width => 860, :height => 200, :image_type => "PNG", :title => "Graph",:defs => [ {:key => "download", :type => "AVERAGE", :rpn => "AREA", :color => "00CC00",:title => "Download" }, {:key => "upload", :type => "AVERAGE", :rpn => "LINE", :color => "0000FF",:title => "Upload" } ] , :base => 1024, :vlabel => "kbits per second", :lowerlimit => 0})
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
