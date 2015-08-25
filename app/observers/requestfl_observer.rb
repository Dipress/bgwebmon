class RequestflObserver < ActiveRecord::Observer
  observe :requestfl

  def after_update record
    if record.changes["requeststatus_id"].nil?
      Requestmailer.requestfl_edited(record, "bgbilling@crimeainfo.com").deliver
      Requestmailer.requestfl_edited(record, record.user.email).deliver
    end
  end
end
