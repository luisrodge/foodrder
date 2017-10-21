class CartFragment < ApplicationRecord
  belongs_to :restaurant
  belongs_to :cart
  has_many :cart_items, dependent: :destroy

  def total
    cf_total = 0.0
    cart_items.each do |cart_item|
      cf_total += cart_item.total
    end
    cf_total
  end

end
