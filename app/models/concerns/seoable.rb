module Seoable
  extend ActiveSupport::Concern

  included do
    attr_accessible :seo
        
    validates :seo, presence: true,
                    length: { maximum: 80 }

    #before_validation :set_seo

    #def to_param
    #  "#{id}_#{seo}".parameterize
    #end
    
    private
    def set_seo
      self.seo = Ctill::Convert.title(self.name)
    end
  end

end