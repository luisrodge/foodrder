class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :food
  belongs_to :order_fragment
end
