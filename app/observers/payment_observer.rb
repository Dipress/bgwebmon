class PaymentObserver < ActiveRecord::Observer
  observe :payment

  def after_create record
    balance = record.contract.balances.where(["yy=? and mm=?", record.dt.year, record.dt.month])
    if balance.length > 0
      balance[0].update_attribute summa2: balance[0].summa2+record.summa
    else
      last = record.contract.balances[balance.length-1]
      summa1 = last.summa1 + last.summa2 - last.summa3 - last.summa4
      Balance.create! yy: record.dt.year, mm: record.dt.month, cid: record.contract.id, summa1: summa1, summa2: record.summa, summa3: 0.0, summa4: 0.0
    end
    #record = .contract.agent_payments.last
    #Paymentmailer.delay.payment_processed(record, "roma@crimeainfo.com")
    #PaymentTasks.new.delay.payment_processed record
  end
end