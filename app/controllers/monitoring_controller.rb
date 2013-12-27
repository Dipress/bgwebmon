# coding: utf-8
class MonitoringController < ApplicationController
respond_to :html, :json
before_filter :checklogedin
  def index
    @title = "Список точек подключения"
    @nodes = ContractParameterType7Value.where(:pid => 54).order('title ASC')
    @regions = regions_array(@nodes)
    @nodes = []
    @regions.each{|r| @nodes << nodes_from_region(r)}
    @user = current_user()
  end

  def mon
    bsid = params[:id]
    if bsid == nil
  	  @dialupalias = make_logins_array(search_title())
      @basestation = "Все абоненты"
    else
      @dialupalias = make_logins_array_bs(search_title(),bsid)
      @basestation = ContractParameterType7Value.find(bsid).title;
    end
  	@title = "Все графики"
    @time = Time.now
    @user = current_user()
  end

  def show
    render :json => create_graph(params[:id],params[:hour].to_i)
    @user = current_user()
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


  def new_mon
    @user = current_user()
    respond_with do |format|
      format.json { render json: Contract.cached_users(current_user.contract_cid), root: false }
      format.html { render 'new_mon' }
    end 
  end

private 
#payments
  def regions_array(nodes)
    scan = /^([А-Я]|[а-я])+\ \-\ /
    array = []
    nodes.each{|z| array << z.title.match(scan).to_s.gsub(/\ \-\ /,"")}
    return array.uniq
  end

  def nodes_from_region(region)
    array = []
    ContractParameterType7Value.where("pid='54' and title like '#{region}%'").order('title ASC').each{|n|
      array << {:id => n.id, :title => n.title}}
    return array = {:region => region, :nodes => array}
  end

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

  def make_logins_array_bs(like,bsid)
    larray = []
    time = Time.now
    ContractParameterType7Value.find(bsid).contracts.each {|c|
      if member(c.id)
        if c.dialuplogins.any?
          c.dialupaliases.each {|s|
            if s.dialuplogin.dialupip != nil
              ip = Dialupip.ntoa(s.dialuplogin.dialupip.ip)
            else
              ip = "1"
            end
            larray << {:online => check_online(ip), 
                       :login_alias => s.login_alias, 
                       :comment => c.comment, 
                       :title => c.title,
                       :closesumma => c.closesumma,
                       :balance => Balance.balance("#{c.id}",
                                                   "#{time.strftime("%m")}",
                                                   "#{time.strftime("%Y")}"),
                       :login_id => s.id,
                       :id => c.id}
          }
        else
          c.inet_services.each do |inet|
            inet.inet_resource_subscriptions.each do |s|
              ip = s.addressFrom.bytes.to_a.join('.')
              larray << {:online => check_online(ip), 
                         :login_alias => inet.login, 
                         :comment => c.comment, 
                         :title => c.title,
                         :closesumma => c.closesumma,
                         :balance => Balance.balance("#{c.id}",
                                                     "#{time.strftime("%m")}",
                                                     "#{time.strftime("%Y")}"),
                         :login_id => s.id,
                         :id => c.id}
            end
          end
        end
      end
    }
    return larray.sort_by {|l| l[:title]}
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
    InetServices.all.each do |inet|
      inet.inet_resource_subscriptions.each do |s|
        ip = s.addressFrom.bytes.to_a.join('.')
        larray << {:online => check_online(ip), 
                    :login_alias => inet.login, 
                    :comment => c.comment, 
                    :title => c.title,
                    :closesumma => c.closesumma,
                    :balance => Balance.balance("#{c.id}",
                                               "#{time.strftime("%m")}",
                                               "#{time.strftime("%Y")}"),
                    :login_id => s.id,
                    :id => c.id}
      end
    end
    return larray.sort_by {|l| l[:title]}
  end

  def check_online(ip)
      cmd="rrdtool fetch /var/www/graphs/#{ip.gsub(/\./,"")}.rrd AVERAGE -r 300 -s -120"
      rxtx=`#{cmd}`
      if rxtx != "" && !rxtx.nil?
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