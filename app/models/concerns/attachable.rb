module Attachable
  extend ActiveSupport::Concern

  included do
    has_one :attachment, as: :attachable, dependent: :destroy
  end
end