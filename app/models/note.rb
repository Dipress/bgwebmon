class Note
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Slug

  belongs_to :user
  belongs_to :note_status, class_name: 'NoteStatus'

  field :fio, type: String
  field :ip, type: String
  field :login, type: String
  field :phone, type: String
  field :bs, type: String
  field :hardware, type: String
  field :mac, type: String
  field :agent, type: String
  field :remark, type: String
  field :latlng_connection, type: String

  slug :login

  validates :bs, :hardware, :agent, :login, :note_status_id, presence: true
end
