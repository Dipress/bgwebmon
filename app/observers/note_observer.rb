class NoteObserver < ActiveRecord::Observer
  observe :note

  def after_create record
    Notemailer.note_added(record, "ruby@crimeainfo.com").deliver
  end

  def after_update record
    Notemailer.note_updated( record, "ruby@crimeainfo.com").deliver
  end
end
