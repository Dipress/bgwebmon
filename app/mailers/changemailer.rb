# coding: utf-8
class Changemailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.changes.send.subject
  # statuses@crimeainfo.com
  def send_changes limits, payments, statuses, to_email, time
    @limits = limits
    @payments = payments
    @statuses = statuses
    mail(from: "ruby.ci.ukrpack.net@crimeainfo.com", to: to_email, subject: "Изменения в бллинга за час: #{I18n.localize(time)}")
  end
end