class OrderFragment < ApplicationRecord
  belongs_to :order
  belongs_to :restaurant
  has_many :order_items

  def total
    of_total = 0.0
    order_items.each do |order_item|
      of_total += order_item.total
    end
    of_total
  end
end
