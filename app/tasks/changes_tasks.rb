# coding: utf-8
class ChangesTasks

  def send_changes
    hour_ago = Time.now - 1.hours
    [{contract: 199, email: "ilnicski.vi@gmail.com"}, 
     {contract: 441, email: "djzubik@gmail.com"}, 
     {contract: 253, email: "bah@crimeainfo.com"}].each do |u|
      statuses = Status.joins(contract: :contract_parameter_type8).where("contract_parameter_type_8.val=#{u[:contract]} AND contract_status_log.date >= '#{hour_ago}'").map{|c| {changer: ((!c.user.nil?)? c.user.name : "Сервер") , changed: "#{c.contract.title} - #{c.contract.comment}", change: ["Активен", "В отключении", "Отключен", "Приостановлен", "В подключении"][c.status], comment: c.comment, updated_at: I18n.localize(c.date)} }
      limits = Limit.joins(contract: :contract_parameter_type8).where("contract_parameter_type_8.val=#{u[:contract]} AND log_contract_limit.dt >= '#{hour_ago}'").map{|c| {changer: ((!c.user.nil?)? c.user.name : "Сервер") , changed: "#{c.contract.title} - #{c.contract.comment}", change: c.nvalue, comment: c.comment, updated_at: I18n.localize(c.dt)} }
      payments = Payment.joins(contract: :contract_parameter_type8).where("contract_parameter_type_8.val=#{u[:contract]} AND contract_payment.lm >= '#{hour_ago}'").map{|c| {changer: ((!c.user.nil?)? c.user.name : "Сервер") , changed: "#{c.contract.title} - #{c.contract.comment}", change: c.summa, comment: c.comment, updated_at: I18n.localize(c.lm)} }
      if statuses.length > 0 && limits.length > 0 && payments.length > 0
        Changemailer.send_changes(limits, payments, statuses, u[:email], hour_ago).deliver
      end
    end
    statuses = Status.where("contract_status_log.date >= '#{hour_ago}'").map{|c| {changer: ((!c.user.nil?)? c.user.name : "Сервер") , changed: "#{c.contract.title} - #{c.contract.comment}", change: ["Активен", "В отключении", "Отключен", "Приостановлен", "В подключении"][c.status], comment: c.comment, updated_at: I18n.localize(c.date)} }
    limits = Limit.where("log_contract_limit.dt >= '#{hour_ago}'").map{|c| {changer: ((!c.user.nil?)? c.user.name : "Сервер") , changed: "#{c.contract.title} - #{c.contract.comment}", change: c.nvalue, comment: c.comment, updated_at: I18n.localize(c.dt)} }
    payments = Payment.where("contract_payment.lm >= '#{hour_ago}'").map{|c| {changer: ((!c.user.nil?)? c.user.name : "Сервер") , changed: "#{c.contract.title} - #{c.contract.comment}", change: c.summa, comment: c.comment, updated_at: I18n.localize(c.lm)} }
    if statuses.length > 0 && limits.length > 0 && payments.length > 0
      Changemailer.send_changes(limits, payments, statuses, "statuses@crimeainfo.com", hour_ago).deliver
    end
    nil
  end

end