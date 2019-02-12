class ReportsController < ApplicationController
  before_filter :checklogedin
  before_filter :sadmin
  before_filter :ip_check

  def index
    @user = current_user()
    @reports = Report.order_by(title: 'asc')
  end

  def new
    @user = current_user()
    @report = Report.new
    @report.nodes.build
  end

  def create
    @user = current_user()
    @report = Report.new(params[:report])
    if @report.save
      redirect_to reports_path
    else
      render :new
    end
  end

  def show
    @user = current_user()
    @report = Report.find(params[:id])
  end

  def edit
    @user = current_user()
    @report = Report.find(params[:id])
  end

  def update
    @user = current_user()
    @report = Report.find(params[:id])
    if @report.update_attributes(params[:report])
      redirect_to reports_path
    else
      render :edit
    end
  end

  def delete
    @user = current_user()
    @report = Report.find(params[:id])
  end

  def destroy
    @user = current_user()
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to @report
  end
end
