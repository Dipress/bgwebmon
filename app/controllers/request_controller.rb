# coding: utf-8
class RequestController < ApplicationController
before_filter :checklogedin
before_filter :ip_check
  def index
    @user = current_user()
    if User.superadmin(@user.id)
      @rfl = Requestfl.where("requeststatus_id = 1 or requeststatus_id = 2 or requeststatus_id = 3 or requeststatus_id=5").order("id ASC")
    else
      @rfl = Requestfl.where("(requeststatus_id = 1 or requeststatus_id = 2 or requeststatus_id = 3 or requeststatus_id=5) and user_id='#{@user.id}'").order("id ASC")      
    end
  end

  def newfl 
    @user = current_user()
    @requestfl = Requestfl.new
  end

  def createfl
    @requestfl = Requestfl.new(params[:requestfl])
    if @requestfl.save
      Requestmailer.requestfl_added(@requestfl, "bgbilling@crimeainfo.com").deliver
      Requestmailer.requestfl_added(@requestfl, @requestfl.user.email).deliver
      redirect_to "/requestfl/#{@requestfl.id}"
    else
      @user = current_user()
      render 'newfl'
    end
  end

  def editfl 
    @user = current_user()
    @requestfl = Requestfl.find(params[:id])
  end

  def updatefl
    @requestfl = Requestfl.find(params[:id])
    if @requestfl.update_attributes params[:requestfl]
      #Requestmailer.requestfl_added(@requestfl, "bgbilling@crimeainfo.com").deliver
      #Requestmailer.requestfl_added(@requestfl, @requestfl.user.email).deliver
      redirect_to "/requestfl/#{@requestfl.id}"
    else
      @user = current_user()
      render 'editfl'
    end
  end

  def requestfl
    @user = current_user()
    @rfl = Requestfl.find(params[:id])
  end

  def readystatusfl
    @rfl = Requestfl.find(params[:id])
    if User.superadmin(current_user().id) && (@rfl.requeststatus_id.eql?(1) || @rfl.requeststatus_id.eql?(5))
      @rfl.update_attribute(:requeststatus_id, 2)
      Requestmailer.requestfl_connected(@rfl, "bgbilling@crimeainfo.com", current_user()).deliver
      Requestmailer.requestfl_connected(@rfl, @rfl.user.email, current_user()).deliver
      redirect_to "/requestfl/#{@rfl.id}", :notice => "Статус успешно обновлен"
    else
      redirect_to "/requestfl/#{@rfl.id}", :error => "Действие невозможно, нарушена процедура"
    end
  end

  def discardflform
    @user = current_user()
  end

  def discardfl
    @rfl = Requestfl.find params[:discard][:id]
    if User.superadmin current_user.id
      @rfl.update_attribute(:requeststatus_id, 5)
      @rfl.update_attribute(:discard, params[:discard][:discard])
      Requestmailer.requestfl_discard(@rfl, "bgbilling@crimeainfo.com", current_user).deliver
      Requestmailer.requestfl_discard(@rfl, @rfl.user.email, current_user).deliver
      redirect_to "/requestfl/#{@rfl.id}", :notice => "Заявка отклонена"
    else
      redirect_to "/requestfl/#{@rfl.id}", :error => "Действие невозможно, нарушена процедура"
    end
  end

  def connectedstatusfl
    @rfl = Requestfl.find(params[:id])
    if (@rfl.user_id.eql?(current_user().id) && @rfl.requeststatus_id.eql?(2)) || (User.superadmin(current_user().id) && @rfl.requeststatus_id.eql?(2))
      @rfl.update_attribute(:requeststatus_id, 3)
      Requestmailer.requestfl_ready(@rfl, "bgbilling@crimeainfo.com", current_user()).deliver
      Requestmailer.requestfl_ready(@rfl, @rfl.user.email, current_user()).deliver
      redirect_to "/requestfl/#{@rfl.id}", :notice => "Статус успешно обновлен"
    else
      redirect_to "/requestfl/#{@rfl.id}", :error => "Действие невозможно, нарушена процедура"
    end
  end

  def finishstatusfl
    @rfl = Requestfl.find(params[:id])
    if User.superadmin(current_user().id) && @rfl.requeststatus_id.eql?(3)
      @rfl.update_attribute(:requeststatus_id, 4)
      Requestmailer.requestfl_finish(@rfl, "bgbilling@crimeainfo.com", current_user()).deliver
      Requestmailer.requestfl_finish(@rfl, @rfl.user.email, current_user()).deliver
      redirect_to "/requestfl/#{@rfl.id}", :notice => "Статус успешно обновлен"
    else
      redirect_to "/requestfl/#{@rfl.id}", :error => "Действие невозможно, нарушена процедура"
    end
  end

  def createul
  end

  def createcp
  end
end
#INSERT INTO contract (gr,title,pswd,date1,mode,closesumma,pgid,fc,comment,sub_list,status) VALUES (16,"99-555","sdfs",NOW(),1,-10.00,1,0,"Тест","",5);
#INSERT INTO contract_module (cid,mid) VALUES (923,2),(923,3),(923,4),(923,6);
#INSERT INTO contract_parameter_type_2 (cid, pid, hid, room, pod, floor, comment, format_key) VALUES (199,5,0,"",0,0,"Киевская","Комментарий","")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,7,"Фамилия")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,11,"Фамилия")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,13,"Фамилия")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,29,"Фамилия")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,24,"Серия паспорта")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,25,"Кем выдан")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,30,"Скорость")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,32,"Протокол")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,34,"IP")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,35,"Шлюз")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,36,"Стоимоть инсталляции")
#INSERT INTO contract_parameter_type_2 (cid, pid, val) VALUES (199,55,"Идентификационный код")
#INSERT INTO contract_parameter_type_phone (pid, cid, value) VALUES (199,9, "00503443515")
#INSERT INTO contract_parameter_type_phone (pid, cid, value) VALUES (199,12, "00503443515")
#INSERT INTO contract_parameter_type_phone (pid, cid, value) VALUES (199,14, "00503443515")
#INSERT INTO contract_parameter_type_5 (cid, pid, val) VALUES (199,46, 1)
#INSERT INTO contract_parameter_type_5 (cid, pid, val) VALUES (199,47, 1)
#INSERT INTO contract_parameter_type_6 (cid, pid, val) VALUES (199,27, NOW()) Паспорт 
#INSERT INTO contract_parameter_type_6 (cid, pid, val) VALUES (199,28, NOW()) Составления
#INSERT INTO contract_parameter_type_6 (cid, pid, val) VALUES (199,41, NOW()) Включения
#INSERT INTO contract_parameter_type_6 (cid, pid, val) VALUES (199,45, 1) VPN-сервер
#INSERT INTO contract_parameter_type_6 (cid, pid, val) VALUES (199,52, 1) Форма оплаты
#INSERT INTO contract_parameter_type_6 (cid, pid, val) VALUES (199,53, 1) Технология передачи данных
#INSERT INTO contract_parameter_type_6 (cid, pid, val) VALUES (199,54, 1) Точка подключения
#INSERT INTO contract_parameter_type_6 (cid, pid, val) VALUES (199,43, 199) Контрагент



