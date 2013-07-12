class RequestflObserver < ActiveRecord::Observer
  observe :requestfl

  def after_update record
    Requestmailer.requestfl_edited(record, "bgbilling@crimeainfo.com").deliver
    Requestmailer.requestfl_edited(record, record.user.email).deliver
  end
end