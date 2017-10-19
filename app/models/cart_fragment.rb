class CartFragment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :cart
  has_many :cart_items, dependent: :destroy
end
