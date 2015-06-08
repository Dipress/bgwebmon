class Note
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Slug

  belongs_to :user, index: true

  field :fio, type: String
  field :ip, type: String
  field :login, type: String
  field :phone, type: String
  field :bs, type: String
  field :hardware, type: String
  field :mac, type: String
  field :agent, type: String
  field :remark, type: String

  index({ login: 1 } , { unique: true })

  slug :login

  validates :bs, :hardware, :agent, :login, presence: true

end
