module Variantable
  extend ActiveSupport::Concern

  included do
    has_many :variants, as: :variantable, validate: false, dependent: :destroy

    accepts_nested_attributes_for :variants
  end

end