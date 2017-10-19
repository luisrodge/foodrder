class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :food
  belongs_to :cart_fragment
end
