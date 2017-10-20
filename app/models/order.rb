class Order < ApplicationRecord
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy

  monetize :total_cents
end
