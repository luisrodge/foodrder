class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :order_fragment
  belongs_to :variant, optional: true
  belongs_to :itemable, polymorphic: true

  def total
    itemable.price || itemable.variantable.price * quantity
  end

end
