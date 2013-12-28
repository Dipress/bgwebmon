class AgentPaymentObserver < ActiveRecord::Observer
  observe :agent_payment

  def after_create record
    Paymentmailer.payment_added(record, "pays@crimeainfo.com").deliver
  end

  def after_update record
    Paymentmailer.payment_processed( record, "pays@crimeainfo.com").deliver
  end
end