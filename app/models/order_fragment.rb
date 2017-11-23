class OrderFragment < ApplicationRecord
  belongs_to :order
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy

  enum status: [:pending_confirmation, :restaurant_notified, :pickup_ready, :processed, :cancelled]


  def total
    of_total = 0.0
    order_items.each do |order_item|
      of_total += order_item.total
    end
    of_total
  end
end
