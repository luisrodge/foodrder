class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :order_fragment
  belongs_to :variant, optional: true
  belongs_to :itemable, polymorphic: true

  has_many :item_additions, as: :item_additionable, validate: false, dependent: :destroy
  has_many :additions, through: :item_additions

  def total
    if itemable.price > 0
      itemable.price
    else
      variant.price * quantity
    end
  end

  def order_item_total
    if variant.present? && additions.any?
      (variant.price + additions_total) * quantity
    elsif variant.present?
      variant.price * quantity
    elsif additions.any?
      (additions_total + itemable.price) * quantity
    else
      itemable.price * quantity
    end
  end

  def item_name
    if variant.present?
      "#{itemable.name} - #{variant.name}"
    else
      itemable.name
    end
  end


  def additions_name
    additions.map{|a| a.name}.join(" ,")
  end

end
