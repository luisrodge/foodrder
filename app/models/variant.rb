class Variant < ApplicationRecord
  belongs_to :variantable, polymorphic: true

  monetize :price_cents

end
