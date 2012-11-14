# coding: utf-8
class TasksController < ApplicationController
  before_filter :checklogedin
  before_filter :ip_check
  def index
  	@user = current_user
  	@tasks = Task.order("created_at DESC")
  end

  def show
  	@user = current_user
  	@task = Task.find params[ :id ]
  	@tcomment = Tcomment.new
  	@tcomments =@task.tcomments
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
  	Requestmailer.task_taken(@task, @user, "notify@crimeainfo.com").deliver
  	Requestmailer.task_taken(@task, @user, "bah@crimeainfo.com").deliver
  	redirect_to task_path(@task), :flash => { :notice =>  "Вы приняли заявку" }
  end

  def tstatuschange
  	@user = current_user
  	@task = Task.find params[ :id ]
  	if @task.update_attribute :tstatus_id, 3
  		Requestmailer.task_end(@task, @user, "notify@crimeainfo.com").deliver
   		Requestmailer.task_end(@task, @user, "bah@crimeainfo.com").deliver
  	  redirect_to task_path(@task), :flash => { :notice =>  "Заявка закрыта" }
  	end
  end

  def tstatuschangeopen
  	@task = Task.find params[ :id ]
  	if @task.update_attribute :tstatus_id, 2
  		Requestmailer.task_restored(@task, @task.user, "notify@crimeainfo.com").deliver
  		Requestmailer.task_restored(@task, @task.user, "bah@crimeainfo.com").deliver
  	  redirect_to task_path(@task), :flash => { :notice =>  "Заявка возобновлена" }
  	end
  end

  def deletetcomment
  	@comment = Tcomment.find params[ :id ]
  	@task = @comment.task
  	@comment.destroy
  	redirect_to task_path(@task), :flash => { :notice =>  "Комментарий удален" }
  end

  def commentcreate
  	@user = current_user
  	@tcomment = Tcomment.new params[ :tcomment ]
  	@tcomment.user_id = current_user.id
  	if @tcomment.save
  		Requestmailer.task_comment(@tcomment.task, @user, "notify@crimeainfo.com").deliver
  		Requestmailer.task_comment(@tcomment.task, @user, "bah@crimeainfo.com").deliver
  		redirect_to task_path(@tcomment.task_id), :flash => { :notice =>  "Комментарий добавлен" }
  	else
  		redirect_to task_path(@tcomment.task_id), :flash => { :error => "Комментарий не добавлен, размер поля не может быть больше 120 символов" }
  	end
  end

  def create
  	@user = current_user
  	@task = Task.new params[ :task ]
  	@task.user_id = @user.id
  	@task.tstatus_id = 1
  	if @task.save
  		Requestmailer.task_created(@task, @task.user, "notify@crimeainfo.com").deliver
  		Requestmailer.task_created(@task, @task.user, "bah@crimeainfo.com").deliver
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
  	@user = current_user
  	@task = Task.find params[ :id ] 
  	if @task.update_attributes params[ :task ]
  		 redirect_to task_path(@task), :flash => { :notice =>  "Изменения внесены" }
  	else
  		render :edit
  	end
  end

  def destroy
  	@task = Task.find params[ :id ] 
  	@task.destroy
  	redirect_to tasks_path
  end
end
