class PaymentObserver < ActiveRecord::Observer
  observe :payment

  def after_create record
    balance = Balance.where(["yy=? and mm=? and cid=?", record.dt.year, record.dt.month, record.contract.id])
    if balance.length > 0
      #balance[0].update_attribute :summa2, balance[0].summa2+record.summa
      ActiveRecord::Base.connection.execute("UPDATE contract_balance SET summa2=#{balance[0].summa2+record.summa} WHERE cid=#{record.contract.id} AND mm=#{record.dt.month} AND yy=#{record.dt.year};");
    else
      count = record.contract.balances
      if count > 0
        last = record.contract.balances[count-1]
        summa1 = last.summa1 + last.summa2 - last.summa3 - last.summa4
        Balance.create! yy: record.dt.year, mm: record.dt.month, cid: record.contract.id, summa1: (summa1+record.summa), summa2: record.summa, summa3: 0.0, summa4: 0.0
      else
        Balance.create! yy: record.dt.year, mm: record.dt.month, cid: record.contract.id, summa1: record.summa, summa2: record.summa, summa3: 0.0, summa4: 0.0
      end
    end
    #record = .contract.agent_payments.last
    #Paymentmailer.delay.payment_processed(record, "roma@crimeainfo.com")
    #PaymentTasks.new.delay.payment_processed record
  end
end