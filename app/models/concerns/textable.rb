module Textable
  extend ActiveSupport::Concern

  included do
    attr_accessible :text
        
    validates :text, presence: true,
                     length: { maximum: 300 }
  end
end