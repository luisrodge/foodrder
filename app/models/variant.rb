class Variant < ApplicationRecord
  belongs_to :variantable, polymorphic: true
end
