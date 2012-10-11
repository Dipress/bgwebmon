# coding: utf-8
class RequestController < ApplicationController
before_filter :checklogedin
before_filter :ip_check
  def index
    @user = current_user()
    if User.superadmin(@user.id)
      @rfl = Requestfl.where("requeststatus_id != 4").order("id ASC")
    else
      @rfl = Requestfl.where("requeststatus_id != 4 and user_id='#{@user.id}'").order("id ASC")      
    end
  end

  def newfl 
    @user = current_user()
    @requestfl = Requestfl.new
  end

  def createfl
    @requestfl = Requestfl.new(params[:requestfl])
    if @requestfl.save
      Requestmailer.requestfl_added(@requestfl, "notify@crimeainfo.com").deliver
      Requestmailer.requestfl_added(@requestfl, @requestfl.user.email).deliver
      redirect_to "/requestfl/#{@requestfl.id}"
    else
      @user = current_user()
      render 'newfl'
    end
  end

  def requestfl
    @user = current_user()
    @rfl = Requestfl.find(params[:id])
  end

  def readystatusfl
    @rfl = Requestfl.find(params[:id])
    if User.superadmin(current_user().id) && @rfl.requeststatus_id.eql?(1)
      @rfl.update_attribute(:requeststatus_id, 2)
      Requestmailer.requestfl_connected(@rfl, "notify@crimeainfo.com", current_user()).deliver
      Requestmailer.requestfl_connected(@rfl, @rfl.user.email, current_user()).deliver
      redirect_to "/requestfl/#{@rfl.id}", :notice => "Статус успешно обновлен"
    else
      redirect_to "/requestfl/#{@rfl.id}", :error => "Действие невозможно, нарушена процедура"
    end
  end

  def connectedstatusfl
    @rfl = Requestfl.find(params[:id])
    if (@rfl.user_id.eql?(current_user().id) && @rfl.requeststatus_id.eql?(2)) || (User.superadmin(current_user().id) && @rfl.requeststatus_id.eql?(2))
      @rfl.update_attribute(:requeststatus_id, 3)
      Requestmailer.requestfl_ready(@rfl, "notify@crimeainfo.com", current_user()).deliver
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
      Requestmailer.requestfl_finish(@rfl, "notify@crimeainfo.com", current_user()).deliver
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
