module Addressable
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressable, dependent: :destroy

    attr_accessible :address_attributes

    accepts_nested_attributes_for :address
  end
end