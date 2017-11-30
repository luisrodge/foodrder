class Variant < ApplicationRecord
  belongs_to :variantable, polymorphic: true

  monetize :price_cents

  validates_presence_of :name

end
