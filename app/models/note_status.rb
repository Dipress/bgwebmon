class NoteStatus
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :title, type: String
  has_many :notes, class_name: 'Note'
end