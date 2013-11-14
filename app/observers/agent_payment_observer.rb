class AgentPaymentObserver < ActiveRecord::Observer
  observe :agent_payment

  def after_create record
    #Paymentmailer.delay.payment_added record, "pays@crimeainfo.com"
    #PaymentTasks.new.delay.charge_added record
    Paymentmailer.payment_added(record, "pays@crimeainfo.com").deliver
  end

  def after_update record
    #Paymentmailer.delay.payment_processed record, "pays@crimeainfo.com"
    #PaymentTasks.new.delay.payment_processed record
    Paymentmailer.payment_added(record, "pays@crimeainfo.com").deliver
  end
end