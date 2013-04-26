module Descriptable
  extend ActiveSupport::Concern

  included do
    attr_accessible :description
        
    validates :description, presence: true
  end
end