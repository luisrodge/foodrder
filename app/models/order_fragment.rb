class OrderFragment < ApplicationRecord
  belongs_to :order
  belongs_to :restaurant
  has_many :order_items
end
