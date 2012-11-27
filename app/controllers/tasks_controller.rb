# coding: utf-8
class TasksController < ApplicationController
  before_filter :checklogedin
  before_filter :ip_check
  def index
  	@user = current_user
  	@user.contract_cid.eql?( 0 ) ? @tasks = Task.order( "created_at DESC" ) : @tasks = Task.where( [ "contract_cid=?", @user.contract_cid ] ).order( "created_at DESC" )
  end

  def show
  	@user = current_user
  	@task = Task.find params[ :id ]
  	@tcomment = Tcomment.new
  	@tcomments = @task.tcomments
    @tfile = Tfile.new
  end

  def new
  	@user = current_user
  	@task = Task.new
  end

  def take
  	@user = current_user
  	@task = Task.find params[ :id ]
  	@task.update_attribute :take_id, @user.id
  	@task.update_attribute :tstatus_id, 2
    send_each( @task )
  	redirect_to task_path( @task ), :flash => { :notice =>  "Вы приняли заявку" }
  end

  def tstatuschange
  	@user = current_user
  	@task = Task.find params[ :id ]
  	if @task.update_attribute :tstatus_id, 3
      send_each( @task )
  	  redirect_to task_path( @task ), :flash => { :notice =>  "Заявка закрыта" }
  	end
  end

  def addfile
    @tfile = Tfile.new params[ :tfile ]
    p params[ :tfile ]
    p "____________________"
    p @tfile
    if @tfile.save
      redirect_to task_path(@tfile.task), :flash => { :notice =>  "Файл добавлен" }
    else
      redirect_to task_path(@tfile.task), :flash => { :error =>  "Файл не добавлне, максимальный размер текста 120 символов" }
    end
  end

  def tstatuschangeopen
  	@task = Task.find params[ :id ]
  	if @task.update_attribute :tstatus_id, 2
      send_each( @task )
  	  redirect_to task_path( @task ), :flash => { :notice =>  "Заявка возобновлена" }
  	end
  end

  def deletetcomment
  	@comment = Tcomment.find params[ :id ]
  	@task = @comment.task
  	@comment.destroy
  	redirect_to task_path( @task ), :flash => { :notice =>  "Комментарий удален" }
  end

  def commentcreate
  	@user = current_user
  	@tcomment = Tcomment.new params[ :tcomment ]
  	@tcomment.user_id = current_user.id
  	if @tcomment.save
      send_each( @task )
  		redirect_to task_path(@tcomment.task_id), :flash => { :notice =>  "Комментарий добавлен" }
  	else
  		redirect_to task_path(@tcomment.task_id), :flash => { :error => "Комментарий не добавлен, размер поля не может быть больше 120 символов" }
  	end
  end

  def create
    params[ :task ][ :observers ] ||= []
  	@user = current_user
  	@task = Task.new params[ :task ]
  	@task.user_id = @user.id
  	@task.tstatus_id = 1
    @task.observers = params[ :task ][ :observers ].join( "," )
    if @user.contract_cid.eql? 0
      if @task.take_id.eql? nil
        @task.contract_cid = 0
      else
        @task.contract_cid = User.find( @task.take_id ).contract_cid
        @task.tstatus_id = 2
      end
    else
      @task.contract_cid = @user.contract_cid
      @task.tstatus_id = 2
    end
  	if @task.save
  		send_each( @task )
  		redirect_to task_path @task
  	else
  		render :new
  	end
  end

  def edit
  	@user = current_user
  	@task = Task.find params[ :id ]
  end

  def update
    params[ :task ][ :observers ] ||= []
  	@user = current_user
  	@task = Task.find params[ :id ]
    @task.observers = params[ :task ][ :observers ].join( "," )
  	if @task.update_attributes params[ :task ]
  		 redirect_to task_path( @task ), :flash => { :notice =>  "Изменения внесены" }
  	else
  		render :edit
  	end
  end

  def destroy
  	@task = Task.find params[ :id ] 
  	@task.destroy
  	redirect_to tasks_path
  end
private

  def send_each( task )
    Requestmailer.task_created( task, task.user, task.user.email ).deliver
    Requestmailer.task_created( task, task.user, User.find(task.take_id).email ).deliver if task.take_id != nil && task.take_id != current_user.id
    task.observers.split( "," ).each{ |o|
      if User.find( o.to_i ).email != nil
        if task.user.id != o.to_i && task.take_id != o.to_i
          Requestmailer.task_created( task, task.user, User.find( o.to_i ).email ).deliver
        end
      end
    }
  end
end
