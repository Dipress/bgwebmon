module Userable
  extend ActiveSupport::Concern

  included do
    attr_accessible :user_id

    belongs_to :user
        
    #validates :user_id, presence: true
    validates :user_id, numericality: { only_integer: true },
                        if: lambda{|m| !m.user_id.nil? }

  end

end