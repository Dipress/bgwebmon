class PaymentObserver < ActiveRecord::Observer
  observe :payment

  def after_create record
  	Paymentmailer.delay.payment_processed(record, "roma@crimeainfo.com")
    PaymentTasks.new.delay.payment_processed record
  end
end