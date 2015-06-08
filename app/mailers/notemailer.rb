# coding: utf-8
class Notemailer < ActionMailer::Base

  def note_added note, to_email
    @note = note
    mail(from: "ruby@crimeainfo.com", to: to_email, subject: "Добавлена предварительная заявка  - #{note.fio}. ")
  end 

  def note_updated note, to_email
    @note = note
    mail(from: "ruby@crimeainfo.com", to: to_email, subject: "Предварительная заявка - #{note.fio} - обновлена.")
  end
end
