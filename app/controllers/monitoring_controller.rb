# coding: utf-8

class MonitoringController < ApplicationController
  http_basic_authenticate_with :name => "crmifc", :password => "crmifc2012",  :except => :dpupdate
def index
  	@dialupalias = Dialupalias.all
  	@title = "Все графики"
  end

  def show
  	@contract = Contract.find(params[:id])
  	@title = "График #{@contract.id}"
  end

  def errorlist
    render :json => errors(params[:id])
  end

  def dpupdate
    render :json => answer(params[:ip],
      					   params[:rx],
      					   params[:tx])
  end

private 
# список ошибок
  def errors(id)
    Dialuplogin.find(id).dialuperrors.order('dt').limit(5)
  end

# Обработка параметров
  # Формирование ответа
  def answer(ip,rx,tx)
  	dialupip = Dialupip.find_aton(ip) if !ip.nil?
  	dialupip.nil? ? stop : updated(dialupip,rx,tx)
  end
  # Обновление 
  def updated(dialupip,rx,tx)
	rxtxnotnil(rx,tx) ? traff(dialupip.contract,rx,tx) : "rx, tx обязательны"
  end
  # Обновляем трафик пользователя
  def traff(contract,rx,tx)
  	contract.update_attributes(:rx => rx, :tx => tx, :online => true) ? "обновленно" : "ошибка"
  end
  # Проверка на nil
  def rxtxnotnil(rx,tx)
  	(!rx.nil? && !tx.nil?) ? true : false
  end
  # Добавляем скорость RailsRRDtools
  def insertspeed(contract,rx,tx)
    upload = ((((rx.to_i - contract.rx)*8)/60)/1024)
    download = ((((tx.to_i - contract.tx)*8)/60)/1024)
  end
  # Eсли IP не найден
  def stop
  	return "нет такого ip"
  end
end
