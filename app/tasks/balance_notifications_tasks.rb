# coding: utf-8

class BalanceNotificationsTasks

  #@@current_day = Time.now.to_date
  #Находим все текущее статусы у которых дата установки текущий день
  #@@last_statuses = ContractStatus.where(date1: @@current_day, date2: nil)
  #Находим нужные договора по найденым cid из статусов
  #@@current_contract = @@last_statuses.map do |f|
    #Contract.find(f.cid)
  #end

  #def self.notification_off
    #@@current_contract.each do |sms|
      #if sms.status.eql?(2) && sms.balance_summa > sms.closesumma
        #Ip2sms.new("#{sms.mobile_phone}", "Услуги Интернет недоступны. Ваш баланс на #{@@current_day}: #{sms.current_balance} руб.").send
      #end
      #if sms.status.eql?(2) && sms.balance_summa < 0 && sms.balance_summa > sms.closesumma
        #Ip2sms.new("#{sms.mobile_phone}", "Услуги Интернет недоступны. Ваш баланс на #{@@current_day}: #{sms.current_balance} руб.").send
      #end
    #end
  #end

  #def self.notification_on
    #@@current_contract.each do |sms|
      #if sms.status.eql?(0) && sms.balance_summa > sms.closesumma
        #Ip2sms.new("#{sms.mobile_phone}", "Услуги Интернет активны. Ваш баланс на #{@@current_day}: #{sms.current_balance} руб.").send
      #end
    #end
  #end

  def self.notification_new
    #Создаем массив данных с заявками которые бы заведены/обновлены в текущий день c 00:00 до 22:00 и имеют статус "готов к подключению"
    сurrent_requests = Requestfl.where(updated_at: Time.now.at_beginning_of_day..Time.now, requeststatus_id: 2)

    #Находим нужные договора по ФИО
    contracts = сurrent_requests.map do |request|
      Contract.find_by_comment(request.fio)
    end
    
    #Теперь отправляем смс-сообщение
    contracts.map do |sms|
      Vostok::Sms.new("INFOCOM", "#{sms.russian_mobile}", "Ваш номер договора: #{sms.title}, пароль от личного кабинета: #{sms.pswd}, адрес личного кабинета: http://billing.crimeainfo.com/").send
    end
  end

  #def self.notification_stoped
    #@@current_contract.each do |sms|
      #if sms.status.eql?(4)
        #Ip2sms.new("#{sms.mobile_phone}", "Договор приостановлен. Ваш баланс на #{@@current_day}: #{sms.current_balance} руб.").send
      #end
    #end
  #end

end
