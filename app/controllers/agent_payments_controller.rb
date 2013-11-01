# coding: utf-8
class AgentPaymentsController < ApplicationController
before_filter :checklogedin
before_filter :ip_check
before_filter :sadmin, only: [:update, :processing, :confirmation ]
  # GET /agent_payments
  # GET /agent_payments.json
  def index
    if User.superadmin(current_user)
      @user = current_user
      agent_payments = AgentPayment.paginate(:page => params[:page],  :per_page => params[:per_page]).order('created_at DESC')
      respond_to do |format|
        format.html # index.html.erb
        format.json { 
                      render json: agent_payments,
                      meta: 
                      {
                        page: agent_payments.current_page,
                        per_page: (params[:per_page] ||  WillPaginate.per_page).to_i,
                        total_pages: agent_payments.total_pages
                      },
                     meta_key: "pagination"
                    }
      end
    else
      @user = current_user
      agent_payments = AgentPayment.where(user_id: current_user.id).paginate(:page => params[:page],  :per_page => params[:per_page]).order('created_at DESC')
      respond_to do |format|
        format.html # index.html.erb
        format.json { 
                      render json: agent_payments,
                      meta: 
                      {
                        page: agent_payments.current_page,
                        per_page: (params[:per_page] ||  WillPaginate.per_page).to_i,
                        total_pages: agent_payments.total_pages
                      },
                     meta_key: "pagination"
                    }
      end
    end
  end

  # GET /agent_payments/1
  # GET /agent_payments/1.json
  def show
    @agent_payment = AgentPayment.find(params[:id])
    @user = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agent_payment, root: false }
    end
  end

  # GET /agent_payments/new
  # GET /agent_payments/new.json
  def new
    @agent_payment = AgentPayment.new
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agent_payment }
    end
  end

  # GET /agent_payments/1/edit
  def edit
    @agent_payment = AgentPayment.find(params[:id])
  end

  # POST /agent_payments
  # POST /agent_payments.json
  def create
    @agent_payment = AgentPayment.new(params[:agent_payment])
    @agent_payment.user_id = current_user.id

    respond_to do |format|
      if @agent_payment.save
        format.html { redirect_to agent_payments_path, notice: 'Agent payment was successfully created.' }
        format.json { render json: @agent_payment, status: :created, location: @agent_payment, root: false }
      else
        format.html { render action: "new" }
        format.json { render json: @agent_payment.errors, status: :unprocessable_entity, root: false }
      end
    end
  end

  def update
    @agent_payment = AgentPayment.find(params[:id])
    respond_to do |format|
      if @agent_payment.update_attributes(params[:agent_payment])
        format.html { redirect_to agent_payments_path, notice: 'Agent payment was successfully updated.' }
        format.json { render json: @agent_payment, root: false }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent_payment.errors, status: :unprocessable_entity, root: false }
      end
    end
    
  end

  # PUT /agent_payments/1
  # PUT /agent_payments/1.json
  def processing
    @agent_payment = AgentPayment.find(params[:id])
    contract = @agent_payment.contract
    last_balance = contract.last_balance
    Payment.create! dt: Time.new, cid: @agent_payment.contract.id, pt: 6, uid: @agent_payment.user.id, summa: @agent_payment.value, comment: @agent_payment.text
    Balance.update_all "summa2=#{(@agent_payment.value + last_balance.summa2)} where yy=#{last_balance.yy} and mm=#{last_balance.mm} and cid=#{last_balance.cid} limit 1"
    if ![0,4].include?(contract.status) && contract.balance_summa > contract.closesumma
      contract.status.build(status: 0, comment: 'Разблокировано системой', uid: 0, date1: Time.now).save
      contract.update_attributes status: 0
    end
    
    respond_to do |format|
      if @agent_payment.update_attributes(manager_id: current_user.id, managed_at: Time.now)
        format.html { redirect_to @agent_payment, notice: 'Agent payment was successfully updated.' }
        format.json { render json: @agent_payment, root: false }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirmation
    @agent_payment = AgentPayment.find(params[:id])
    respond_to do |format|
      if @agent_payment.update_attributes(confirmation_id: current_user.id, confirmation_at: Time.now)
        format.html { redirect_to @agent_payment, notice: 'Agent payment was successfully updated.' }
        format.json { render json: @agent_payment, root: false }
      else
        format.html { render action: "edit" }
        format.json { render json: @agent_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agent_payments/1
  # DELETE /agent_payments/1.json
  def destroy
    @agent_payment = AgentPayment.find(params[:id])
    @agent_payment.destroy

    respond_to do |format|
      format.html { redirect_to agent_payments_url }
      format.json { head :no_content }
    end
  end
end
