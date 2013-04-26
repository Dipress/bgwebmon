class AgentPaymentObserver < ActiveRecord::Observer
  observe :agent_payment

  def after_create record
  	Paymentmailer.delay.payment_added(record, "roma@crimeainfo.com")
    PaymentTasks.new.delay.charge_added record
  end
end