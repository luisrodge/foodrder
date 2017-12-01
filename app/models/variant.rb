class Variant < ApplicationRecord
  belongs_to :restaurant
  belongs_to :variantable, polymorphic: true

  has_many :order_items, as: :itemable
  has_many :cart_items, as: :itemable

  monetize :price_cents

  validates_presence_of :name

end
