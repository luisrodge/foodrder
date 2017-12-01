class OrderFragment < ApplicationRecord
  belongs_to :order
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy

  enum status: [:pending, :pending_pickup_ready, :processed, :cancelled]


  def food_order_items
    order_items.where(itemable_type: "Food")
  end

  def total
    of_total = 0.0
    order_items.each do |order_item|
      of_total += order_item.total
    end
    of_total
  end
end
