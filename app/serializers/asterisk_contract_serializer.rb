class AsteriskContractSerializer < ActiveModel::Serializer
  attributes :title, :comment, :balance, :narabotka

  def balance
    last_balance.summa1 + last_balance.summa2 - last_balance.summa3 - last_balance.summa4
  end

  def narabotka
    last_balance.summa3
  end

private
  def last_balance
    @last_balance ||= get_last_balance
  end

  def get_last_balance
    summa = object.balances.order("yy DESC").first
    if summa.nil?
      summa = Balance.new summa1: 0, summa2: 0, summa3: 0, summa4: 0
    end
    summa
  end
end