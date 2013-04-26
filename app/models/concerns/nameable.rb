module Nameable
  extend ActiveSupport::Concern

  included do
    attr_accessible :name
        
    validates :name, presence: true,
                     length: { maximum: 60 }
  end
end